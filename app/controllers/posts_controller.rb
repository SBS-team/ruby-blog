class PostsController < ApplicationController

  def index
    @posts = Post.includes(:admin, :tags).enabled.load.order('posts.created_at DESC').paginate(per_page: 5, page: params[:page])
  end

  def show
    @post = Post.includes(:tags, :admin, :comments).enabled.find_by_slug!(params[:id])
  end

  def posts_by_tag
    @posts = Post.joins(:tags).includes(:admin).where('tags.name = ?', tag_params[:name]).enabled.load.order('posts.created_at DESC').paginate(per_page: 5, page: params[:page])
    @posts.blank? ? render('public/404.html', status: 404, layout: false) : render(:index)
  end

  def posts_search
    @search_request = search_params[:request]
    if @search_request.blank?
      redirect_to root_path
    else
      search = Post.enabled.includes(:tags, :admin).search(:message_or_subject_cont => @search_request)
      @posts = search.result(distinct: true).order('posts.created_at DESC').paginate(:per_page => 5, :page => params[:page])
      render :index
    end
  end

  def comment_create

    @comment = Comment.create( params.permit(:comment))
    @comment.current_admin = current_admin

    if @comment.valid_with_captcha? and @comment.save
      render :json => {:comment => render_to_string(:partial => "comment", :locals => {:comment => @comment}), :captcha => render_to_string(:partial => "captcha")}
    else
      render :json => {:errors => @comment.errors, :captcha => render_to_string(:partial => "captcha")}
    end
  end

  private
  def tag_params
    params.permit(:name)
  end

  def search_params
    params.permit(:request, :page)
  end

end