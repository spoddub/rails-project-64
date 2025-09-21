# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @posts = Post.includes(:category, :creator).order(created_at: :desc).limit(20)
  end
end
