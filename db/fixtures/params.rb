require 'securerandom'
User.seed do |u|
  u.id = 1
  u.email = "auto_reply@ngs.com"
  u.password = SecureRandom.hex(12)
  u.age = 20
  u.gender = 'Male'
  u.country_of_residence = 'Japan'
  u.role = 'respondent'
end
