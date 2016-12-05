class ImageSearchController < ApplicationController
  def search
    query = params[:query].downcase.gsub(/\W+/, "+")
    url = "https://www.google.co.uk/search?q=#{query}&tbm=isch"
    @images = Nokogiri::HTML(open(url).read).css("#search img").map { |i| i["src"] }
  end
end
