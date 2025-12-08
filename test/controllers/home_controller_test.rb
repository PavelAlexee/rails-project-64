# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path

    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test 'index should load posts with category and creator' do
    get root_path

    post = posts(:one)

    assert { assigns(:posts).include?(post) }
    assert { assigns(:posts).first.category == categories(:two) }
    assert { assigns(:posts).first.creator == users(:two) }
  end
end
