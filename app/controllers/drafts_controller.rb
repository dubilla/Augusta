class DraftsController < ApplicationController
  def show
    @draft = Draft.find(params[:id])
  end
end
