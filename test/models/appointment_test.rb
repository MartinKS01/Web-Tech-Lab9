require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  def valid_owner
    Owner.create!(
      first_name: "Martin",
      last_name: "Karl",
      email: "martin_appt_test@email.com",
      phone: "934741283"
    )
  end

  def valid_pet
    Pet.create!(
      name: "Max",
      species: "dog",
      breed: "Labrador",
      date_of_birth: "2019-03-15",
      weight: 28.5,
      owner: valid_owner
    )
  end

  def valid_vet
    Vet.create!(
      first_name: "Ana",
      last_name: "Garcia",
      email: "ana_appt_test@vetclinic.com",
      phone: "998143276",
      specialization: "General Practice"
    )
  end

  def valid_appointment
    Appointment.new(
      pet: valid_pet,
      vet: valid_vet,
      date: DateTime.now + 1,
      reason: "Annual checkup",
      status: :scheduled
    )
  end

  test "valid appointment can be saved" do
    assert valid_appointment.valid?
  end

  test "date is required" do
    appt = valid_appointment
    appt.date = nil
    assert_not appt.valid?
    assert_includes appt.errors[:date], "can't be blank"
  end

  test "reason is required" do
    appt = valid_appointment
    appt.reason = nil
    assert_not appt.valid?
    assert_includes appt.errors[:reason], "can't be blank"
  end

  test "pet is required" do
    appt = valid_appointment
    appt.pet = nil
    assert_not appt.valid?
    assert appt.errors[:pet].any?
  end

  test "vet is required" do
    appt = valid_appointment
    appt.vet = nil
    assert_not appt.valid?
    assert appt.errors[:vet].any?
  end

  test "status enum works correctly" do
    appt = valid_appointment
    appt.status = :completed
    assert appt.completed?
  end
end