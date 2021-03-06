class UsersController < ApplicationController
  before_filter :find_post, :except => [:index]

  def index
    @posts = Post.includes(:admin, :tags).order("posts.created_at DESC").enabled.paginate(:per_page => 5, :page => params[:page])
  end

  def show
  end

  def create
    @comment = @post.comments.build(users_params)
    @comment.current_admin = current_admin

    if @comment.valid_with_captcha? and @comment.save
      render :json => {:comment => render_to_string(:partial => "comment", :locals => {:comment => @comment}), :captcha => render_to_string(:partial => "captcha")}
    else
      render :json => {:errors => @comment.errors, :captcha => render_to_string(:partial => "captcha")}
    end
  end

  private

  def users_params
    params.permit(:page, :comment)
  end

  def find_post
    unless @post = Post.includes(:tags,:comments).enabled.find_by(:id => params[:id])
      redirect_to root_path
      flash[:error] = "Post not found"
    end
  end

end
