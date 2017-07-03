FactoryGirl.define do
  factory :user_login, class: User, aliases: [:user1_login, :kaname_login, :first_user_login] do
    email "kaname@kaname.co.jp"
    password "kaname"
  end

  factory :tama_login, class: User, aliases: [:user2_login, :second_user_login] do
    email "tama@tama.co.jp"
    password "tamatama"
  end
end
