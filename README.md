## Seeded User Credentials
 
Three users are created on seed, one of each role:
 
| Role  | Email                  | Password    |
|-------|------------------------|-------------|
| Admin | admin@vetclinic.com    | password123 |
| Vet   | vet@vetclinic.com      | password123 |
| Owner | owner@vetclinic.com    | password123 |

## Devise Customization
 
- first_name and last_name are added to the user model, also added to the signup and update with "configure_permitted_parameters" in "ApplicationController".

- role created using an integer (owner: 0, vet: 1, admin: 2). The roles were created but don't change anything yet for the permissions of users
 — role assignment happens only through seeds or the Rails console.
- After sign-in and sign-out, flash messages confirm the action.


## System Dependencies

### libvips (required for image variants)

Active Storage uses libvips to resize and crop pet photos into thumbnails.

** With Homebrew:**
```bash
brew install vips
```


## Setup & Running

```bash
bundle install
bin/rails db:setup
bin/rails server
```


## Trix Sanitization Check

Action Text uses the Trix editor, which sanitizes all HTML input by default.

**Verification:** When `<script>alert(1)</script>` was pasted into the clinical notes rich text editor and saved, no alert fired on the appointment show page, and rich editor was working correctly. The script tag was stripped from the rendered HTML only safe, formatted content was displayed.