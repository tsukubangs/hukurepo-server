User.seed do |u|
  u.id = 1
  u.email = ENV['MANAGER_EMAIL']
  u.password = ENV['MANAGER_PASSWORD']
  u.age = 20
  u.gender = 'Male'
  u.country_of_residence = 'Japan'
  u.role = 'respondent'
end
