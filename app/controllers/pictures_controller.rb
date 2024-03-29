class PicturesController < ApplicationController
  before_action :check_admin, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 or /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    if current_user.admin?
      @picture = Picture.new
    else
      redirect_to pictures_path, alert: "No tienes permiso para subir una nueva imagen."
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures or /pictures.json
  def create
    if current_user.admin?
      @picture = current_user.pictures.build(picture_params)
      respond_to do |format|
        if @picture.save
          format.html { redirect_to picture_url(@picture), notice: "Picture was successfully created." }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Only admins can create pictures."
      end
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:name, :description, :context, :url)
    end
end
