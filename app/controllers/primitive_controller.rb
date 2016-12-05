class PrimitiveController < ApplicationController
  def index
  end

  def create
    in_filename = params[:picture].tempfile.path
    out_filename = in_filename.gsub("/tmp/", "/tmp/out-")
    `./bin/primitive -i #{in_filename} -o #{out_filename} -n 50 -s 400`
    render text: File.read(out_filename), content_type: "image/jpeg"
  end

  def create_from_url
    expires_in 30.minutes

    if image = Image.find_by_seed(params[:url])
      render text: open(image.result).read, content_type: "image/jpeg"
    else
      in_filename = "/tmp/#{Digest::SHA1.hexdigest(params[:url])}.jpg"
      out_filename = in_filename.gsub("/tmp/", "/tmp/out-")
      IO.copy_stream(open(params[:url]), in_filename)
      `./bin/primitive -i #{in_filename} -o #{out_filename} -n 50 -s 400`

      url = Cloudinary::Uploader.upload(out_filename,
                                        public_id: "shuffled-#{Digest::SHA1.hexdigest(params[:url])}.jpg",
                                        cloud_name: "charlieegan3",
                                        api_key: ENV['CLOUDINARY_KEY'],
                                        api_secret: ENV['CLOUDINARY_SECRET'])['url']

      Image.create(seed: params[:url], result: url)

      render text: File.read(out_filename), content_type: "image/jpeg"
    end
  end
end
