include ActionDispatch::TestProcess

FactoryGirl.define do
# first_userからsecond_userが作成したproblem2への返答1
  factory :response1, aliases: [:response], class: Response do
    comment "Please go to the Tsukuba Center"
    user { build(:user1) }
    problem { build(:problem2) }
  end
  # second_userからfirst_userが作成したproblem1への返答1
  factory :response2, class: Response do
    comment "Go to Keio Univesity"
    user { build(:user2) }
    problem { build(:problem1) }
  end
# first_userからsecond_userが作成したproblem2への返答2
  factory :response3, class: Response do
    comment "Please go to Daigaku Kaikan Mae"
    user { build(:user1) }
    problem { build(:problem2) }
  end
end
