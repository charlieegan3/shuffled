class PrimitiveController < ApplicationController
  def index
  end

  def create
    in_filename = params[:picture].tempfile.path
    out_filename = in_filename.gsub("/tmp/", "/tmp/out-")
    `./bin/primitive -i #{in_filename} -o #{out_filename} -n 50`
    render text: File.read(out_filename), content_type: "image/jpeg"
  end

  def create_from_url
    in_filename = "/tmp/#{Digest::SHA1.hexdigest(params[:url])}.jpg"
    out_filename = in_filename.gsub("/tmp/", "/tmp/out-")
    IO.copy_stream(open(params[:url]), in_filename)
    `./bin/primitive -i #{in_filename} -o #{out_filename} -n 50`
    expires_in 2.hours
    render text: File.read(out_filename), content_type: "image/jpeg"
  end
end
