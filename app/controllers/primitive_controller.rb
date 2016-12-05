class PrimitiveController < ApplicationController
  def index
    # render text: `./bin/primitive`
  end

  def create
    in_filename = params[:picture].tempfile.path
    out_filename = in_filename.gsub("/tmp/", "/tmp/out-")
    `./bin/primitive -i #{in_filename} -o #{out_filename} -n 50`
    render text: File.read(out_filename), content_type: "image/jpeg"
  end
end
