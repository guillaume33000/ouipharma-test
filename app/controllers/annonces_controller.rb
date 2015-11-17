class AnnoncesController < ApplicationController
  def home
    @annonces = Annonce.all
  end

  def show
    @annonce = Annonce.find(params[:id])
  end

  def new
    @annonce = Annonce.new
  end

  def create
    @annonce = Annonce.new(annonce_params)
    if @annnonce.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def annonce_params
    params.require(:annonce).permit(:title, :picture)
  end
end
