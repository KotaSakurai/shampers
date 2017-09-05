FactoryGirl.define do
  factory :tag do
    name "good"
    shampoo_id 1
    user_id 1
  end

  factory :name_dup_tag do
    name "good"
    shampoo_id 2
    user_id 1
  end
end
