admin = User.first_or_initialize(email: "admin@aed-crm.com")
admin.password = "pass123!"
admin.password_confirmation = "pass123!"
admin.country = "USA"
admin.name = "Access Education Admin"
admin.confirmed_at = DateTime.now
admin.save!
