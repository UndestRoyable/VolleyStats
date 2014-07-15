module ApplicationHelper
  def javascript(name, options = {})
    content_for :javascripts do
      javascript_include_tag name, options
    end
  end

  def stylesheet(name, options = {})
    content_for :stylesheets do
      javascript_include_tag name, options
    end
  end
end
