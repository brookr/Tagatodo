class TagsController < ApplicationController
  layout false

  def index
    get_tasks

    respond_to do |format|
      format.html { render :partial => 'list' }
      format.json { render json: @todos }
    end
  end
end
