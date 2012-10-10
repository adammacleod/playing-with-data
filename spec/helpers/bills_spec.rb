require 'spec_helper'

describe BillsHelper do
  context "format_duration" do
    it "formats durations in hours" do
      format_duration(5614).should eq("01:33:34")
    end

    it "formats durations in minutes" do
      format_duration(1152).should eq("00:19:12")
    end

    it "formats durations in seconds" do
      format_duration(55).should eq("00:00:55")
    end

    it "formats durations in days" do
      format_duration(269703).should eq("3d 02:55:03")
    end

    it "returns nil for negative durations" do
      format_duration(-1).should be_nil
    end

    it "formats durations of 0" do
      format_duration(0).should eq("00:00:00")
    end
  end
end
