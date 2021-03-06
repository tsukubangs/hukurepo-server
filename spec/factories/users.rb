FactoryGirl.define do
  factory :user, class:User, aliases: [:user1, :user_kaname, :first_user] do
    email "kaname@kaname.co.jp"
    password "kaname"
    country_of_residence "Japan"
    gender "male"
    age 20
    role 'poster'
  end

  factory :user_tama, class: User, aliases: [:user2, :second_user] do
    email "tama@tama.co.jp"
    password "tamatama"
    country_of_residence "Japan"
    gender "female"
    age 50
    role 'respondent'
  end

  factory :user_shinjin, class: User, aliases: [:user3, :third_user] do
    email "shinjin@shinjin.co.jp"
    password "shinjin"
    country_of_residence "Japan"
    gender "male"
    age 40
    role 'poster'
  end
end
