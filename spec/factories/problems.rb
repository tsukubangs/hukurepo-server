include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :problem, aliases: [:problem1] do
    comment "SOX is difficult"
    image { fixture_file_upload Rails.root.join('spec', 'file', 'noimage.jpg'), 'image/jpg' }
    latitude 36.10830528664971
	  longitude 140.10114337330694
    user { User.exists? ? User.first : create(:user) }
  end

  factory :problem2, class: Problem do
    comment "Where is Bus stop?"
    image { fixture_file_upload Rails.root.join('spec', 'file', 'noimage.jpg'), 'image/jpg' }
    latitude 36.10830528664373
	  longitude 140.10114337330311
    user do
       create(:user) unless User.exists?
       User.second ? User.second : create(:user_tama)
    end
  end

  factory :problem3, class: Problem do
    comment "Bicycle is too many!!!"
    image { fixture_file_upload Rails.root.join('spec', 'file', 'noimage.jpg'), 'image/jpg' }
    latitude 36.1181461
    longitude 140.0903428
    user { User.exists? ? User.first : create(:user) }
  end


end
