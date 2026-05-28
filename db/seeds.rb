Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all
User.destroy_all

User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

User.create!(
  first_name: "Ana",
  last_name: "Garcia",
  email: "vet@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :vet
)

User.create!(
  first_name: "Martin",
  last_name: "Karl",
  email: "owner@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :owner
)

owner1 = Owner.create!(
  first_name: "Martin",
  last_name: "Karl",
  email: "martin@email.com",
  phone: "934741283",
  address: "Cristobal colon 123, Santiago"
)

owner2 = Owner.create!(
  first_name: "Sofia",
  last_name: "Torres",
  email: "sofia@email.com",
  phone: "986482163",
  address: "av. la plaza 132, Valparaiso"
)

owner3 = Owner.create!(
  first_name: "Diego",
  last_name: "Morales",
  email: "diego@email.com",
  phone: "938902751",
  address: "aysen 123, Concepcion"
)

vet1 = Vet.create!(
  first_name: "Ana",
  last_name: "Garcia",
  email: "ana@vetclinic.com",
  phone: "998143276",
  specialization: "General Practice"
)

vet2 = Vet.create!(
  first_name: "Carlos",
  last_name: "Lopez",
  email: "carlos@vetclinic.com",
  phone: "908154761",
  specialization: "Surgery"
)

pet1 = Pet.create!(
  owner: owner1,
  name: "Max",
  species: "dog",
  breed: "Labrador",
  date_of_birth: "2019-03-15",
  weight: 28.5
)

photo1_path = Rails.root.join("db/seeds/pets/dog.jpg")
if File.exist?(photo1_path)
  pet1.photo.attach(io: File.open(photo1_path), filename: "dog.jpg", content_type: "image/jpeg")
end

pet2 = Pet.create!(
  owner: owner1,
  name: "Marrito",
  species: "cat",
  breed: "Siamese",
  date_of_birth: "2021-07-20",
  weight: 4.2
)

photo2_path = Rails.root.join("db/seeds/pets/cat.jpg")
if File.exist?(photo2_path)
  pet2.photo.attach(io: File.open(photo2_path), filename: "cat.jpg", content_type: "image/jpeg")
end

pet3 = Pet.create!(
  owner: owner2,
  name: "Coco",
  species: "rabbit",
  breed: "Holland Lop",
  date_of_birth: "2022-01-10",
  weight: 1.8
)

photo3_path = Rails.root.join("db/seeds/pets/rabbit.jpg")
if File.exist?(photo3_path)
  pet3.photo.attach(io: File.open(photo3_path), filename: "rabbit.jpg", content_type: "image/jpeg")
end

pet4 = Pet.create!(
  owner: owner1,
  name: "Lupe",
  species: "dog",
  breed: "Border Collie",
  date_of_birth: "2016-02-16",
  weight: 25.0
)

photo4_path = Rails.root.join("db/seeds/pets/dog.jpg")
if File.exist?(photo4_path)
  pet4.photo.attach(io: File.open(photo4_path), filename: "dog.jpg", content_type: "image/jpeg")
end

pet5 = Pet.create!(
  owner: owner3,
  name: "Mia",
  species: "cat",
  breed: "Persian",
  date_of_birth: "2021-11-30",
  weight: 3.9
)

appointment1 = Appointment.create!(
  pet: pet1, vet: vet1,
  date: DateTime.now + 3,
  reason: "Annual checkup",
  status: :scheduled
)

appointment2 = Appointment.create!(
  pet: pet2, vet: vet1,
  date: DateTime.now - 1,
  reason: "Vaccination",
  status: :completed
)

appointment3 = Appointment.create!(
  pet: pet3, vet: vet2,
  date: DateTime.now,
  reason: "Dental cleaning",
  status: :in_progress
)

appointment4 = Appointment.create!(
  pet: pet4, vet: vet2,
  date: DateTime.now - 7,
  reason: "Leg injury",
  status: :completed
)

appointment5 = Appointment.create!(
  pet: pet5, vet: vet1,
  date: DateTime.now + 7,
  reason: "Skin irritation",
  status: :cancelled
)

Treatment.create!(
  appointment: appointment2,
  name: "Vaccination",
  medication: "Rabies vaccine",
  dosage: "1ml",
  administered_at: DateTime.now - 1,
  clinical_notes: "<h2>Vaccination Notes</h2><p>Patient tolerated the vaccine <strong>very well</strong>.</p><ul><li>No adverse reactions observed</li><li>Next dose due in 12 months</li></ul>"
)

Treatment.create!(
  appointment: appointment2,
  name: "Deworming",
  medication: "Fenbendazole",
  dosage: "0.5ml",
  administered_at: DateTime.now - 1,
  clinical_notes: "<p>Routine deworming administered without complications.</p>"
)

Treatment.create!(
  appointment: appointment3,
  name: "Dental Cleaning",
  medication: "Anesthesia",
  dosage: "2ml",
  administered_at: DateTime.now,
  clinical_notes: "<h2>Dental Cleaning Report</h2><p>Full dental cleaning performed.</p><ul><li>Teeth in <strong>good condition</strong></li><li>No extractions needed</li><li>Recommend cleaning every 6 months</li></ul>"
)

Treatment.create!(
  appointment: appointment4,
  name: "Pain Relief",
  medication: "Meloxicam",
  dosage: "1.5ml",
  administered_at: DateTime.now - 7,
  clinical_notes: "<h2>Pain Management</h2><p>Administered for <strong>leg pain</strong> following injury.</p><ul><li>Follow up in 2 weeks</li><li>Restrict physical activity</li></ul>"
)

Treatment.create!(
  appointment: appointment4,
  name: "Bandaging",
  medication: "None",
  dosage: "N/A",
  administered_at: DateTime.now - 7,
  clinical_notes: "<p>Leg bandaged successfully. Keep <strong>dry for 5 days</strong>. Return for bandage change if soiled.</p>"
)

puts "Seed data created successfully!"
puts "#{User.count} users"
puts "#{Owner.count} owners"
puts "#{Vet.count} vets"
puts "#{Pet.count} pets"
puts "#{Appointment.count} appointments"
puts "#{Treatment.count} treatments"