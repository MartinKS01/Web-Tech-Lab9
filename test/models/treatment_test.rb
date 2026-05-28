require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  def valid_appointment
    owner = Owner.create!(
      first_name: "Martin",
      last_name: "Karl",
      email: "martin_treat_test@email.com",
      phone: "934741283"
    )
    pet = Pet.create!(
      name: "Max",
      species: "dog",
      breed: "Labrador",
      date_of_birth: "2019-03-15",
      weight: 28.5,
      owner: owner
    )
    vet = Vet.create!(
      first_name: "Ana",
      last_name: "Garcia",
      email: "ana_treat_test@vetclinic.com",
      phone: "998143276",
      specialization: "General Practice"
    )
    Appointment.create!(
      pet: pet,
      vet: vet,
      date: DateTime.now - 1,
      reason: "Checkup",
      status: :completed
    )
  end

  def valid_treatment
    Treatment.new(
      appointment: valid_appointment,
      name: "Vaccination",
      medication: "Rabies vaccine",
      dosage: "1ml",
      administered_at: DateTime.now
    )
  end

  test "valid treatment can be saved" do
    assert valid_treatment.valid?
  end

  test "name is required" do
    treatment = valid_treatment
    treatment.name = nil
    assert_not treatment.valid?
    assert_includes treatment.errors[:name], "can't be blank"
  end

  test "administered_at is required" do
    treatment = valid_treatment
    treatment.administered_at = nil
    assert_not treatment.valid?
    assert_includes treatment.errors[:administered_at], "can't be blank"
  end

  test "appointment is required" do
    treatment = valid_treatment
    treatment.appointment = nil
    assert_not treatment.valid?
    assert treatment.errors[:appointment].any?
  end
end