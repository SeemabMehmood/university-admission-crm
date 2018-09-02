admin = User.first_or_initialize(email: "admin@aed-crm.com", password: "pass123!", password_confirmation: "pass123!", country: "USA", name: "Access Education Admin", confirmed_at: DateTime.now)
admin.save!
