[![CI](https://github.com/spoddub/rails-project-64/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/spoddub/rails-project-64/actions/workflows/ci.yml)
[![hexlet-check](https://github.com/spoddub/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg?branch=main)](https://github.com/spoddub/rails-project-64/actions/workflows/hexlet-check.yml)

# Collective Blog

A small Rails app where users create posts by category, discuss them in a threaded comments tree, and like posts they enjoy.  
Uses Devise for auth, Ancestry for comments hierarchy, and Slim + Bootstrap for UI.

**Live:** https://rails-project-64.onrender.com

## Features

- User sign up / sign in (Devise)
- Post categories (one-to-many)
- Create posts from the personal account area
- Threaded comments (Ancestry)
- Post likes (PostLike)
- Slim templates and Bootstrap styling

## Requirements

- Ruby **3.2.2**
- Rails **7.2**
- Node.js **18+** (Render uses 24.x)
- PostgreSQL (production)
- Yarn/NPM for assets

## Setup & Run (local)

```bash
# Clone and install deps
git clone https://github.com/spoddub/rails-project-64.git
cd rails-project-64
bundle install
npm ci

# DB (migrations + seeds)
bin/rails db:prepare
bin/rails db:seed

# Linters & tests
make lint
make slim
make test

# Start server
bin/rails s
# Open http://localhost:3000
```

````markdown
## Core entities

- `Category` — `name` (unique), `has_many :posts`
- `Post` — `title`, `body`, `category_id`, `creator_id (User)`, `has_many :post_likes`
- `PostComment` — `content`, `user_id`, `post_id`, `ancestry` (Ancestry)
- `PostLike` — `user_id`, `post_id` (+ unique composite index)

## Routing (excerpt)

```ruby
root "pages#home"

resources :posts, only: %i[show] do
  resource  :like,     only: %i[create destroy], controller: "likes"
  resources :comments, only: %i[create],         controller: "comments"
end

namespace :account do
  resources :posts, only: %i[index new create]
end
```
````

````markdown
## Usage

1. Sign up or sign in.
2. Categories are pre-seeded (`db/seeds.rb`); add more if needed.
3. Create posts under **Account → New post**.
4. On a post page:
   - add comments (including replies),
   - like / unlike the post.
5. The home page shows a global feed.

## Tests (Minitest)

```bash
# All tests
make test

# Specific file / single test
bin/rails test test/controllers/comments_controller_test.rb
bin/rails test test/controllers/comments_controller_test.rb -n "/creates_child_comment/"
```
````

```markdown
## Deploy on Render

- Build runs `./bin/render-build.sh`
- Migrations run on startup
- Live app: https://rails-project-64.onrender.com

> If migrations fail due to duplicate columns (e.g., `creator_id`), check migration history and ensure `schema.rb` matches the production DB.

## This project was built using these tools

| Tool / Library        | Purpose                          |
| --------------------- | -------------------------------- |
| Ruby 3.2.2, Rails 7.2 | Backend framework                |
| Devise                | Authentication                   |
| Ancestry              | Comment tree (materialized path) |
| Slim, Bootstrap       | Templates & styling              |
| esbuild, Sass         | Asset bundling                   |
| Minitest              | Testing                          |
| RuboCop, slim-lint    | Linting                          |
| Render                | Production hosting               |
```
