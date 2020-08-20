FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question

    trait :invalid do
      body { nil }
    end
  end
end
