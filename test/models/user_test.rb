require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should register user success" do
    user = User.create(email: 'test1@qq.com', password: '123123')
    assert user.save
  end

  test "should register user fail" do
    user = User.new(email: '', password: '123123')
    assert_not user.save

    user = User.create(email: 'test2@qq.com', password: '')
    assert_not user.save
  end
end
