FactoryGirl.define do
  factory :user do
    name "Kurosawa"
    email "test@test.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
    activated true
  end

  factory :active_user do
    name "Kurosawa"
    email "test@test.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
  end

  factory :other_user, class: User do
    name "takeda"
    email "take@take.com"
    password "fooboo"
    password_confirmation "fooboo"
    age 23
    gender 1
  end
end
