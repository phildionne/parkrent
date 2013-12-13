require 'spec_helper'

describe ScheduleValidator do

  describe :validate_end_time_is_after_start_time do
    let(:schedule) { build(:schedule, start_time: Date.today, end_time: Date.yesterday) }

    it "validates end time is after start time" do
      schedule.valid?
      expect(schedule).to have(1).error_on(:end_time)
    end
  end

  describe :validate_start_time_not_in_past do
    let(:schedule) { build(:schedule, start_time: Date.yesterday) }

    it "validates start time not in the past" do
      schedule.valid?
      expect(schedule).to have(1).error_on(:start_time)
    end
  end
end
