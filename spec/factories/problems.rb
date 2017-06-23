include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :problem do
    comment "SOX is difficult"
    image { fixture_file_upload Rails.root.join('spec', 'file', 'noimage.jpg'), 'image/jpg' }
    latitude 36.10830528664971
	  longitude 140.10114337330694
    user_id 1
  end
end
