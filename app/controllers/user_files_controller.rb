class UserFilesController < ApplicationController
  before_action :set_user_file, only: [:show, :destroy]

  # GET /user_files
  # GET /user_files.json
  def index
    @user_files = UserFile.all
  end

  # GET /user_files/1
  # GET /user_files/1.json
  def show
    send_file @user_file.local_path
  end

  def upload
    name = params[:name] || params[:upload_file].original_filename
    local_path = Rails.root.join('public', 'uploads', name)
    File.open(local_path, 'wb') do |file|
      file.write(params[:upload_file].read)
    end

    UserFile.new(name: name, local_path: local_path.to_s).save

    redirect_to "/user_files"
  end

  # DELETE /user_files/1
  # DELETE /user_files/1.json
  def destroy
    @user_file.destroy
    respond_to do |format|
      format.html { redirect_to user_files_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_file
      @user_file = UserFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_file_params
      params[:user_file].permit(:name, :local_path)
    end
end
