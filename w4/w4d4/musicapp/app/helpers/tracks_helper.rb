module TracksHelper
  include ERB::Util
  
  def ugly_lyrics(lyrics)
    html = lyrics.strip.split("\r\n").map do |line|
      "<pre>" + "&#9835;  " + h(line) + "</pre>"
    end
    html.join("").html_safe
  end
end
