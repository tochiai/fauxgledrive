class UserFilesController < ApplicationController
  before_action :set_user_file, only: [:show, :edit, :update, :destroy]

  # GET /user_files
  # GET /user_files.json
  def index
    @user_files = UserFile.all
  end

  # GET /user_files/1
  # GET /user_files/1.json
  def show
  end

  # GET /user_files/new
  def new
    @user_file = UserFile.new
  end

  # GET /user_files/1/edit
  def edit
  end

  # POST /user_files
  # POST /user_files.json
  def create
    @user_file = UserFile.new(user_file_params)

    respond_to do |format|
      if @user_file.save
        format.html { redirect_to @user_file, notice: 'User file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_files/1
  # PATCH/PUT /user_files/1.json
  def update
    respond_to do |format|
      if @user_file.update(user_file_params)
        format.html { redirect_to @user_file, notice: 'User file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end
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

  def save_file(file_object)
    basename = File.basename(file_object)
    f = UserFile.new(name: basename, local_path: "/tmp/fauxgle_drive/#{basename}")
    f.save
    FileUtils.cp(file_object.path, "/tmp/fauxgle_drive/#{basename}")
  end

  def get_file_by_name(name)
    queried_file = UserFile.find_by name: name
    File.open(queried_file.local_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_file
      @user_file = UserFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_file_params
      params[:user_file]
    end
end