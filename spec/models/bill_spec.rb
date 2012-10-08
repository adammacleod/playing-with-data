require 'spec_helper'

describe Bill do
  it "has a valid Factory" do
    FactoryGirl.create(:bill).should be_valid
  end

  it "is invalid without a csv" do
    FactoryGirl.build(:call, csv: nil).should_not be_valid
  end
end
