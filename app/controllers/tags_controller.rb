class TagsController < ApplicationController
  def new
  end

  def create
    @tag = Tag.new(tag_params.merge(user_id: 1))
    if @tag.save
      flash[:info] = "Posted Shampoo!"
      redirect_to root_url
    else
      flash[:danger] = "You couldn't post"
      redirect_to root_url
    end
  end

  def destroy
    @tag = Tag.find_by(id: params[:id])
    @tag.destroy if @tag
    redirect_to root_url
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :shampoo_id)
  end
end
