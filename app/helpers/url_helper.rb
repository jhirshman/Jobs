module UrlHelper
  def urlHelp(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
end