module ApplicationHelper
  def active_link_to(text, url = "", options = {})
    url = polymorphic_path(url) unless url.is_a?(String)
    options[:class] = "active" if url == controller.request.path_info
    link_to text, url, options
  end
end
