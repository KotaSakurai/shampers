class ShampoosController < ApplicationController
  def index
    @shampoos = Shampoo.page(params[:page])
    @tag = Tag.new
  end

  def show
    if 
      @shampoo = Shampoo.find_by(id: params[:id])
    else
      redirect_to root_path
    end
    @user = current_user
  end

  def edit
    @shampoo = Shampoo.find_by(id: params[:id])
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

  def destroy
    if shampoo = Shampoo.find_by(id: params[:id])
      shampoo.destroy
    end
    redirect_to root_path
  end

  private

  def shampoo_params
    params.require(:shampoo).permit(:name, :price, :storage, :image)
  end
end
