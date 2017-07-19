class ShampoosController < ApplicationController
  def index
    @shampoos = Shampoo.page(params[:page])
    @tag = Tag.new
    @tags = Tag.all
  end

  def show
    @shampoo = Shampoo.find(params[:id])
    @user = current_user
  end

  def edit
    @shampoo = Shampoo.find(params[:id])
  end

  def new
    @shampoo = Shampoo.new
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

  def update
    @shampoo = Shampoo.find(params[:id])
    if @shampoo.update_attributes(shampoo_params)
      flash[:sucess] = "Profile updated"
      redirect_to @shampoo
    else
      render 'edit'
    end
  end

  private

  def shampoo_params
    params.require(:shampoo).permit(:name, :price, :storage, :image)
  end
end
