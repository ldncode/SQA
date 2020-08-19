FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyTextQuestion" }

    user

    trait :invalid do
      title { nil }
    end
  end
end
