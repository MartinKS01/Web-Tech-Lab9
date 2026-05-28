require "test_helper"

class VetTest < ActiveSupport::TestCase
  def valid_vet
    Vet.new(
      first_name: "Ana",
      last_name: "Garcia",
      email: "ana_model_test@vetclinic.com",
      phone: "998143276",
      specialization: "General Practice"
    )
  end

  test "valid vet can be saved" do
    assert valid_vet.valid?
  end

  test "first_name is required" do
    vet = valid_vet
    vet.first_name = nil
    assert_not vet.valid?
    assert_includes vet.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    vet = valid_vet
    vet.last_name = nil
    assert_not vet.valid?
    assert_includes vet.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    vet = valid_vet
    vet.email = nil
    assert_not vet.valid?
    assert_includes vet.errors[:email], "can't be blank"
  end

  test "email must be unique" do
    valid_vet.save!
    duplicate = valid_vet
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "email must have valid format" do
    vet = valid_vet
    vet.email = "not-an-email"
    assert_not vet.valid?
    assert vet.errors[:email].any?
  end

  test "specialization is required" do
    vet = valid_vet
    vet.specialization = nil
    assert_not vet.valid?
    assert_includes vet.errors[:specialization], "can't be blank"
  end

  test "email is normalized to lowercase" do
    vet = valid_vet
    vet.email = "ANA@VETCLINIC.COM"
    vet.valid?
    assert_equal "ana@vetclinic.com", vet.email
  end
end