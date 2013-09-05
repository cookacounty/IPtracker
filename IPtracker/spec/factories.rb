FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :silicon do
    sequence(:name)  {|n| "%04dXX" % [n]}
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :cdslib do
    sequence(:name)  { |n| "LIB#{n}" }
  end
  
  factory :cdscell do
    sequence(:name)   { |n| "CELL#{n}" }
    sequence(:xsize)  { |n| 20+n }
    sequence(:ysize)  { |n| 30+n }
    sequence(:area)   { |n| 100+n }
    cdslib
  end
  
end