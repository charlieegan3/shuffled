class ImageSearchController < ApplicationController
  def search
    query = params[:query].downcase.gsub(/\W+/, "+")
    url = "https://www.google.co.uk/search?q=#{query}&tbm=isch"
    @images = Nokogiri::HTML(open(url).read).css("#search img").map { |i| i["src"] }

    respond_to do |format|
      format.html { render :search }
      format.json { render json: @images.map { |i| CGI.escape(i) }.as_json }
    end
  end
end
