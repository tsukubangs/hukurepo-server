include ActionDispatch::TestProcess

FactoryGirl.define do
# first_userからsecond_userが作成したproblem2への返答1
  factory :response1_to_problem2, class: Response do
    comment "Please go to the Tsukuba Center"
    user { User.exists? ? User.first : create(:user) }
    problem do
      create(:problem1) unless Problem.exists?
      Problem.second ? Problem.second : create(:problem2)
    end
  end
  # second_userからfirst_userが作成したproblem1への返答1
  factory :response1_to_problem1, class: Response do
    comment "Go to Keio Univesity"
    user do
      create(:user) unless User.exists?
      User.second ? User.second : create(:user_tama)
    end
    problem { Problem.exists? ? Problem.first : create(:problem1) }
  end
# first_userからsecond_userが作成したproblem2への返答2
  factory :response2_to_problem2, class: Response do
    comment "Please go to Daigaku Kaikan Mae"
    user {User.exists? ? User.first : create(:user) }
    problem do
      create(:problem1) unless Problem.exists?
      Problem.second ? Problem.second : create(:problem2)
    end
  end
end
