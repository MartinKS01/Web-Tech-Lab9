require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = vets(:ana)
  end

  test "should get index" do
    get vets_url
    assert_response :success
  end

  test "should get show" do
    get vet_url(@vet)
    assert_response :success
  end

  test "should create vet with valid params" do
    assert_difference("Vet.count") do
      post vets_url, params: { vet: { first_name: "New", last_name: "Vet", email: "newvet@clinic.com", phone: "999999999", specialization: "Dermatology" } }
    end
    assert_redirected_to vet_url(Vet.last)
    assert_equal "Vet was successfully created.", flash[:notice]
  end

  test "should not create vet with invalid params" do
    assert_no_difference("Vet.count") do
      post vets_url, params: { vet: { first_name: "", last_name: "", email: "bad", phone: "", specialization: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update vet with valid params" do
    patch vet_url(@vet), params: { vet: { specialization: "Surgery" } }
    assert_redirected_to vet_url(@vet)
    assert_equal "Vet was successfully updated.", flash[:notice]
  end

  test "should destroy vet" do
    assert_difference("Vet.count", -1) do
      delete vet_url(@vet)
    end
    assert_redirected_to vets_url
    assert_equal "Vet was successfully deleted.", flash[:notice]
  end
end