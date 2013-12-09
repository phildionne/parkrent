FactoryGirl.define do
  factory :schedule do
    start_time { Date.today.in(7.hours) }
    end_time   { Date.today.in(18.hours) }
  end

  factory :invalid_schedule, parent: :schedule do
    start_time nil
    end_time   nil
  end
end
