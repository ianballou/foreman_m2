FactoryBot.modify do
  factory :compute_resource do
    trait :m2 do
      provider 'M2'
      url 'http://127.0.0.1:1234'
    end

    #factory :m2_cr, :class => ForemanM2::M2, :traits => [:m2]
  end
end
