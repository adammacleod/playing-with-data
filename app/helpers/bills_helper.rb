module BillsHelper
  def format_duration(duration)
    return nil if duration < 0

    duration = duration.floor

    minutes, seconds = duration.divmod(60)
    hours, minutes = minutes.divmod(60)
    days, hours = hours.divmod(24)

    time = [hours,minutes,seconds].map { |v| v.to_s.rjust(2, "0") }.join(':')
    time = "#{days}d #{time}" if days != 0
    time
  end
end
