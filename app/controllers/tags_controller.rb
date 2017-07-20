class TagsController < ApplicationController
  def new
  end

  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      flash[:info] = "Posted Shampoo!"
      redirect_to root_path
    else
      flash[:denger] = "You couldn't post"
      redirect_to root_url
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :shampoo_id)
  end
end
