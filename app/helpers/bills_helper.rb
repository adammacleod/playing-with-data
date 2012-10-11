module BillsHelper
  def format_duration(duration)
    duration = duration.to_i
    return nil if duration < 0

    duration = duration.floor

    minutes, seconds = duration.divmod(60)
    hours, minutes = minutes.divmod(60)
    days, hours = hours.divmod(24)

    time = [hours,minutes,seconds].map { |v| v.to_s.rjust(2, "0") }.join(':')
    time = "#{days}d #{time}" if days != 0
    time
  end

  def generate_invalid_call_field(call, field)
    message = ""
    css_class = ""
    value = call.read_attribute(field)
    if call.error_messages[field].any?
        message = call.error_messages[field].join("\n")
        css_class = "alert alert-error"
    end
    content_tag('td', value, :class => css_class, :title => message)
  end
end
