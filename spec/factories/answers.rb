FactoryBot.define do
  factory :answer do
    body { "MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
