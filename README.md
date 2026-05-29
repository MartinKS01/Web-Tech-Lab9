## Seeded User Credentials
 
Three users are created on seed, one of each role:
 
| Role  | Email                  | Password    |
|-------|------------------------|-------------|
| Admin | admin@vetclinic.com    | password123 |
| Vet   | vet@vetclinic.com      | password123 |
| Vet2  | vet2@vetclinic.com     | password123 |
| Owner | owner@vetclinic.com    | password123 |
| Owner2| owner2@vetclinic.com   | password123 |

## Authentication & Authorization

Authorization is enforced using Pundit based on user roles.

### Role Matrix

- **Admin**: Full CRUD on every resource. 
- **Vet**: Read-only on owners and pets. Can edit their own vet profile. Can create/update/destroy their own appointments and treatments.
- **Owner**: Can view/edit their own owner record. Can manage their own pets and appointments. Read-only on vets.





## Trix Sanitization Check

Action Text uses the Trix editor, which sanitizes all HTML input by default.

**Verification:** When `<script>alert(1)</script>` was pasted into the clinical notes rich text editor and saved, no alert fired on the appointment show page, and rich editor was working correctly. The script tag was stripped from the rendered HTML only safe, formatted content was displayed.