class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  def new
    # @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@bookmark.list)
    else
      render :new
    end
  end

  def destroy
    Bookmark.find(params[:id]).delete
    redirect_back fallback_location: lists_path # check the method to refresh (and not redirect)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :photo)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
