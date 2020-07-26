# frozen_string_literal: true

module ApplicationHelper
  def current_class?(path)
    current_page?(path) ? 'active' : 'navbutton'
  end
end
