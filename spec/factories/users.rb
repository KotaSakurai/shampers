FactoryGirl.define do
  factory :user do
    name "KKKtest"
    email "test@test.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
  end
end
