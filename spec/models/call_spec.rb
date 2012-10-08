require 'spec_helper'

describe Call do
  it "has a valid Factory" do
    FactoryGirl.create(:call).should be_valid
  end

  #
  # Tests for presence
  #
  it "is invalid without a source" do
    FactoryGirl.build(:call, source: nil).should_not be_valid
  end
  it "is invalid without a destination" do
    FactoryGirl.build(:call, destination: nil).should_not be_valid
  end
  it "is invalid without a datetime" do
    FactoryGirl.build(:call, datetime: nil).should_not be_valid
  end
  it "is invalid without a duration" do
    FactoryGirl.build(:call, duration: nil).should_not be_valid
  end
  it "is invalid without a cost" do
    FactoryGirl.build(:call, cost: nil).should_not be_valid
  end
  it "is invalid without a bill" do
    FactoryGirl.build(:call, bill: nil).should_not be_valid
  end

  #
  # Duration
  #
  it "is invalid with a negative duration" do
    FactoryGirl.build(:call, duration: -1).should_not be_valid
  end

  it "is valid with a 0 duration" do
    FactoryGirl.build(:call, duration: 0).should be_valid
  end

  #
  # Cost
  #
  it "is invalid with negative cost" do
    FactoryGirl.build(:call, cost: -0.01).should_not be_valid
  end
  it "is valid with 0 cost" do
    FactoryGirl.build(:call, cost: 0.00).should be_valid
  end
end
