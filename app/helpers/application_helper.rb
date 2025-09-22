# frozen_string_literal: true

module ApplicationHelper
  def safe_l(time, format: :short, **opts)
    return '' if time.nil?

    l(time, { format: format }.merge(opts))
  rescue StandardError
    time.to_s
  end
end
