FactoryGirl.define do
  factory :user do
    email "kaname@kaname.co.jp"
    password "kaname"
    nationality "Japan"
    gender "male"
    age 20
  end

  factory :user_tama, class: User do
    email "tama@tama.co.jp"
    password "tamatama"
    nationality "Japan"
    gender "female"
    age 50
  end
end
