class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy favorite ]

  # GET /picutres or /picutres.json
  def index
    @picutres = Picture.all
  end

  # GET /picutres/1 or /picutres/1.json
  def show
  end

  # GET /picutres/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
  end

  # GET /picutres/1/edit
  def edit
    if @picture.user_id != session[:user_id]
      redirect_to picture_url(@picture)
    end
  end

  # POST /picutres or /picutres.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = session[:user_id]

    respond_to do |format|
      if @picture.save
        ConfirmMailer.send_mail(@picture).deliver_now
        format.html { redirect_to picture_url(@picture), notice: t("appname.page.picture.notice.create") }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /picutres/1 or /picutres/1.json
  def update
    if @picture.user_id != session[:user_id]
      redirect_to pictures_url
    else
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to picture_url(@picture), notice: t("appname.page.picture.notice.update") }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /picutres/1 or /picutres/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: t("appname.page.picture.notice.destroy") }
      format.json { head :no_content }
    end
  end

  def favorite
    favorite = Favorite.find_by(picture_id: @picture.id, user_id: session[:user_id])
    if favorite
      favorite.is_enabled = !favorite.is_enabled
      favorite.save
    else
      favorite = Favorite.new
      favorite.user_id = session[:user_id]
      favorite.picture_id = @picture.id
      favorite.is_enabled = true
      favorite.save
    end
    redirect_to picture_path(@picture)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end
end
