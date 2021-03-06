require 'spec_helper'

describe Call do
  let(:call) { Call.new }

  it "has a valid Factory" do
    FactoryGirl.create(:call).should be_valid
  end

  #
  # Tests for presence
  #
  context "presence" do
    it "is invalid without a source" do
      FactoryGirl.build(:call, source: nil).should_not be_valid
    end
    it "is invalid without a destination" do
      FactoryGirl.build(:call, destination: nil).should_not be_valid
    end
    it "is invalid without a date" do
      FactoryGirl.build(:call, date: nil).should_not be_valid
    end
    it "is invalid without a time" do
      FactoryGirl.build(:call, time: nil).should_not be_valid
    end
    it "is invalid without a duration" do
      FactoryGirl.build(:call, duration: nil).should_not be_valid
    end
    it "is invalid without a cost" do
      FactoryGirl.build(:call, cost: nil).should_not be_valid
    end
    it "is valid without a bill" do
      FactoryGirl.build(:call, bill: nil).should be_valid
    end
  end

  #
  # Duration
  #
  context "duration" do
    it "is invalid with a negative duration" do
      FactoryGirl.build(:call, duration: -1).should_not be_valid
    end

    it "is valid with a 0 duration" do
      FactoryGirl.build(:call, duration: 0).should be_valid
    end

    it "is invalid with a malformed duration" do
      FactoryGirl.build(:call, duration: "m:al:fo:rm").should_not be_valid
    end

    it "converts duration strings expressed as hh:mm:ss to seconds" do
      call.duration = "1:33:34"
      call.duration.should eq(5614)
    end

    it "converts duration strings expressed as mm:ss to seconds" do
      call.duration = "19:12"
      call.duration.should eq(1152)
    end

    it "accepts a string representing an integer as a valid duration" do
      call.duration = "55"
      call.duration.should eq(55)
    end

    it "accepts an empty duration string as nil" do
      call.duration = ""
      call.duration.should eq(nil)
    end
  end

  #
  # Cost
  #
  context "cost" do
    it "is invalid with negative cost" do
      FactoryGirl.build(:call, cost: -0.01).should_not be_valid
    end
    it "is valid with 0 cost" do
      FactoryGirl.build(:call, cost: 0.00).should be_valid
    end
  end

  #
  # Time
  #
  context "time" do
    it "is invalid with negative value" do
      FactoryGirl.build(:call, time: "-1").should_not be_valid
    end
    it "is invalid with alphanumeric value" do
      FactoryGirl.build(:call, time: "a").should_not be_valid
    end
  end
end
