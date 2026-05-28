require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:martin)
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should get show" do
    get owner_url(@owner)
    assert_response :success
  end

  test "should create owner with valid params" do
    assert_difference("Owner.count") do
      post owners_url, params: { owner: { first_name: "New", last_name: "Owner", email: "new@email.com", phone: "123456789", address: "Test St" } }
    end
    assert_redirected_to owner_url(Owner.last)
    assert_equal "Owner was successfully created.", flash[:notice]
  end

  test "should not create owner with invalid params" do
    assert_no_difference("Owner.count") do
      post owners_url, params: { owner: { first_name: "", last_name: "", email: "bad-email", phone: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update owner with valid params" do
    patch owner_url(@owner), params: { owner: { first_name: "Updated" } }
    assert_redirected_to owner_url(@owner)
    assert_equal "Owner was successfully updated.", flash[:notice]
  end

  test "should destroy owner" do
    assert_difference("Owner.count", -1) do
      delete owner_url(@owner)
    end
    assert_redirected_to owners_url
    assert_equal "Owner was successfully deleted.", flash[:notice]
  end
end