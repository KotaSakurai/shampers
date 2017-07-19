class TagsController < ApplicationController
  def new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:info] = "Posted Shampoo!"
      redirect_to root_path
    else
      redirect_to root_url
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :shampoo_id, :user_id)
  end
end
