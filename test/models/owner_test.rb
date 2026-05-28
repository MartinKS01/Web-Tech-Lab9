require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  def valid_owner
    Owner.new(
      first_name: "Martin",
      last_name: "Karl",
      email: "martin_model_test@email.com",
      phone: "934741283",
      address: "Cristobal Colon 123"
    )
  end

  test "valid owner can be saved" do
    assert valid_owner.valid?
  end

  test "first_name is required" do
    owner = valid_owner
    owner.first_name = nil
    assert_not owner.valid?
    assert_includes owner.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    owner = valid_owner
    owner.last_name = nil
    assert_not owner.valid?
    assert_includes owner.errors[:last_name], "can't be blank"
  end

  test "email is required" do
    owner = valid_owner
    owner.email = nil
    assert_not owner.valid?
    assert_includes owner.errors[:email], "can't be blank"
  end

  test "email must be unique" do
    valid_owner.save!
    duplicate = valid_owner
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "email must have valid format" do
    owner = valid_owner
    owner.email = "not-an-email"
    assert_not owner.valid?
    assert owner.errors[:email].any?
  end

  test "phone is required" do
    owner = valid_owner
    owner.phone = nil
    assert_not owner.valid?
    assert_includes owner.errors[:phone], "can't be blank"
  end

  test "email is normalized to lowercase" do
    owner = valid_owner
    owner.email = "MARTIN@EMAIL.COM"
    owner.valid?
    assert_equal "martin@email.com", owner.email
  end
end