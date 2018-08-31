User.create! do |u|
  u.email    = 'admin@aed-crm.com'
  u.password = 'pass123!'

  u.country = "USA"
  u.name = "Access Education Admin"
  u.confirmed_at = DateTime.now
end
