FactoryGirl.define do
  factory :user do
    name "Kurosawa"
    email "test@test.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
    activated false
    admin 1

    trait :activated do
      activated true
    end
  end

  factory :active_user do
    name "Kurosawa2"
    email "test@test2.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
  end

  factory :not_active_user do
    name "Kurosawa3"
    email "test@tes3.com"
    password "foobar"
    password_confirmation "foobar"
    age 23
    gender 1
    activated false
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
