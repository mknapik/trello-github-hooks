# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :board do
    uid { generate_id(5) }
    name { Faker::Company::name }
    repository
  end

  factory :repository do
    name { Faker::Company::name }
    user
  end

  factory :user do
    email { "#{Faker::Name::first_name}.#{Faker::Name::last_name}@example.com".downcase }
    password 'password'

    trello_api_key { generate_id(6) }
    trello_token { generate_id(20) }
  end
end

