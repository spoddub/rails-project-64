# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'valid factory-like' do
    c = Category.new(name: 'Категория')
    assert { c.valid? }
  end
  test 'name presence and uniqueness' do
    Category.create!(name: 'Уникальная')
    dup = Category.new(name: 'Уникальная')
    assert { !dup.valid? }
  end
end
