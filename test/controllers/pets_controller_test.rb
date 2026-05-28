require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:max)
    @owner = owners(:martin)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get show" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should create pet with valid params" do
    assert_difference("Pet.count") do
      post pets_url, params: { pet: { name: "Buddy", species: "dog", breed: "Poodle", date_of_birth: "2020-01-01", weight: 5.0, owner_id: @owner.id } }
    end
    assert_redirected_to pet_url(Pet.last)
    assert_equal "Pet was successfully created.", flash[:notice]
  end

  test "should not create pet with invalid params" do
    assert_no_difference("Pet.count") do
      post pets_url, params: { pet: { name: "", species: "dragon", breed: "", date_of_birth: "", weight: -1 } }
    end
    assert_response :unprocessable_entity
  end

  test "should update pet with valid params" do
    patch pet_url(@pet), params: { pet: { name: "Updated" } }
    assert_redirected_to pet_url(@pet)
    assert_equal "Pet was successfully updated.", flash[:notice]
  end

  test "should destroy pet" do
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end
    assert_redirected_to pets_url
    assert_equal "Pet was successfully deleted.", flash[:notice]
  end
end