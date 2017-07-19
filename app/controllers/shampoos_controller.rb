class ShampoosController < ApplicationController
  def index
    @shampoo = Shampoo.new
  end

  def show
    @shampoo = Shampoo.find(params[:id])
  end

  def edit
  end

  def new
  end

  def create
    @shampoo = Shampoo.new(shampoo_params)
    if @shampoo.save
      flash[:info] = "Posted Shampoo!"
      redirect_to @shampoo
    else
      render 'new'
    end
  end

  private

  def shampoo_params
    params.require(:shampoo).permit(:name, :price, :storage, :image)
  end
end
