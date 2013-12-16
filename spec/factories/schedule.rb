FactoryGirl.define do
  factory :schedule do
    start_time       { (Date.today + 1.month).at_beginning_of_day }
    end_time         { start_time + [1, 2, 3].sample.send([:days, :weeks, :months].sample) }
    daily_start_hour { [6, 7, 8].sample }
    daily_end_hour   { [17, 18, 19].sample }
    weekend          { [true, false].sample }
  end

  factory :invalid_schedule, parent: :schedule do
    start_time       nil
    end_time         nil
    daily_start_hour nil
    daily_end_hour   nil
    weekend          nil
  end
end
