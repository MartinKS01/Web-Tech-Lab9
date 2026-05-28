require "test_helper"

class TreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:vaccination)
    @treatment = treatments(:rabies)
  end

  test "should create treatment with valid params" do
    assert_difference("Treatment.count") do
      post appointment_treatments_url(@appointment), params: { treatment: { name: "New Treatment", medication: "Med", dosage: "1ml", administered_at: Time.now, notes: "Notes" } }
    end
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully added.", flash[:notice]
  end

  test "should not create treatment with invalid params" do
    assert_no_difference("Treatment.count") do
      post appointment_treatments_url(@appointment), params: { treatment: { name: "", administered_at: nil } }
    end
    assert_response :unprocessable_entity
  end

  test "should update treatment with valid params" do
    patch appointment_treatment_url(@appointment, @treatment), params: { treatment: { name: "Updated" } }
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully updated.", flash[:notice]
  end

  test "should destroy treatment" do
    assert_difference("Treatment.count", -1) do
      delete appointment_treatment_url(@appointment, @treatment)
    end
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully deleted.", flash[:notice]
  end
end