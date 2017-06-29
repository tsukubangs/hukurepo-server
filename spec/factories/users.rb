FactoryGirl.define do
  factory :user, aliases: [:user1, :user_kaname, :first_user] do
    email "kaname@kaname.co.jp"
    password "kaname"
    nationality "Japan"
    gender "male"
    age 20
  end

  factory :user_tama, class: User, aliases: [:user2, :second_user] do
    email "tama@tama.co.jp"
    password "tamatama"
    nationality "Japan"
    gender "female"
    age 50
  end
end
