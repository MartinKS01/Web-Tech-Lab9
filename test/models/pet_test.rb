require "test_helper"

class PetTest < ActiveSupport::TestCase
  def valid_owner
    Owner.create!(
      first_name: "Martin",
      last_name: "Karl",
      email: "martin_pet_test@email.com",
      phone: "934741283"
    )
  end

  def valid_pet
    Pet.new(
      name: "Max",
      species: "dog",
      breed: "Labrador",
      date_of_birth: "2019-03-15",
      weight: 28.5,
      owner: valid_owner
    )
  end

  test "valid pet can be saved" do
    assert valid_pet.valid?
  end

  test "name is required" do
    pet = valid_pet
    pet.name = nil
    assert_not pet.valid?
    assert_includes pet.errors[:name], "can't be blank"
  end

  test "species is required" do
    pet = valid_pet
    pet.species = nil
    assert_not pet.valid?
    assert_includes pet.errors[:species], "can't be blank"
  end

  test "species must be valid" do
    pet = valid_pet
    pet.species = "dragon"
    assert_not pet.valid?
    assert pet.errors[:species].any?
  end

  test "date_of_birth is required" do
    pet = valid_pet
    pet.date_of_birth = nil
    assert_not pet.valid?
    assert_includes pet.errors[:date_of_birth], "can't be blank"
  end

  test "date_of_birth cannot be in the future" do
    pet = valid_pet
    pet.date_of_birth = Date.tomorrow
    assert_not pet.valid?
    assert_includes pet.errors[:date_of_birth], "cannot be in the future"
  end

  test "weight is required" do
    pet = valid_pet
    pet.weight = nil
    assert_not pet.valid?
    assert_includes pet.errors[:weight], "can't be blank"
  end

  test "weight must be greater than 0" do
    pet = valid_pet
    pet.weight = 0
    assert_not pet.valid?
    assert pet.errors[:weight].any?
  end

  test "owner is required" do
    pet = valid_pet
    pet.owner = nil
    assert_not pet.valid?
    assert pet.errors[:owner].any?
  end

  test "name is capitalized before saving" do
    pet = valid_pet
    pet.name = "max"
    pet.save!
    assert_equal "Max", pet.name
  end
end