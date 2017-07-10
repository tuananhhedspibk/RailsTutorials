class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_active_relationship, except: :index

  def index
    @user = User.find_by id: params[:user_id]
    render_not_found unless @user
    type = params[:type]
    @users = @user.send(type).paginate page: params[:page]
    @title = t type.to_s
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    @relationship_destroy = @active_rela.find_by followed_id: @user.id
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    @relationship_build = @active_rela.build
  end

  private

  def find_active_relationship
    @active_rela = current_user.active_relationships
  end
end
