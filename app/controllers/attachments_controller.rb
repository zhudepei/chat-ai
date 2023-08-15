class AttachmentsController < ApplicationController

  def create
    file = params[:file]
    extension = File.extname(file.original_filename)

    @attachment = ActiveStorage::Blob.create_and_upload!(io: file, filename: "#{Time.now.to_i}#{extension}")

    render json: { "file_id": @attachment.id }, status: :ok
  end

end