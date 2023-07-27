class UploadsController < ApplicationController
  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      render json: { url: @upload.file.url }
    else
      render json: { errors: @upload.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:file, :uploadable_type, :uploadable_id)
  end
end
