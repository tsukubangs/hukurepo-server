include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :response, aliases: [:response1] do
    comment "Please go to the Tsukuba Center"
    user { User.exists? ? User.first : create(:user) }
    problem do
      create(:problem1) unless Problem.exists?
      Problem.second ? Problem.second : create(:problem2)
    end
  end

  factory :response2, class: Response do
    comment "Please go to Daigaku Kaikan Mae"
    user {User.exists? ? User.first : create(:user) }
    problem do
      create(:problem1) unless Problem.exists?
      Problem.second ? Problem.second : create(:problem2)
    end
  end

end
