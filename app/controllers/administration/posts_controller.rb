class Administration::PostsController < Administration::MainController

  before_filter :find_post, :only => [:update, :destroy, :edit]
  include VkontakteHelper

  def index
    @search = Post.includes(:admin).search(posts_params || {'meta_sort' => 'id.asc'})
    @posts = @search.result(distinct: true).paginate(:per_page => 20, :page => params[:page])
  end

  def update
    if @post.update_attributes(posts_params[:post])
      flash[:notice] = 'Post successfully updated'
      unless @post.status
        message += repost_on_group_wall(@post) ? ' and' : ' but don\'t'
        message += ' reposted on Vkontakte wall.'
      end
      redirect_to administration_post_path
    else
      flash[:error] = @post.errors.full_messages
      render :action => :edit
    end
  end

  def show
    @post = Post.includes([:comments, :tags]).friendly.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_admin.posts.build(posts_params[:post])
    if @post.save
      message = 'Post successfully saved'
      unless @post.status
        message += repost_on_group_wall(@post) ? ' and' : ' but don\'t'
        message += ' reposted on Vkontakte wall.'
      end
      flash[:notice] = message
      redirect_to administration_post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      render :action => :new
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Destroyed successfully'
    redirect_to administration_posts_path
  end

  def preview
    @tags = []
    @post= Post.where(:id => params[:id]).first || Post.new
    render :layout => 'application'
  end

  def load_repost_settings
    @vk_params = YAML.load_file(File.join(Rails.root, 'config', 'application.yml'))[Rails.env]['vk']
    render 'repost_settings'
  end

  def save_repost_settings
    full_path_to_yaml = File.join(Rails.root, 'config', 'application.yml')
    config = YAML.load_file(full_path_to_yaml)
    config[Rails.env]['vk'].merge!(params[:vk])
    File.open(full_path_to_yaml, 'w') {|f| f.write config.to_yaml }
    flash[:notice] = 'Save settings successfully'
  rescue
    flash[:error] = 'Save settings not saved'
  ensure
    redirect_to :back
  end

  private
  def posts_params
    params.permit(post: [:subject, :message, :status, :truncate_character])
  end

  def find_post
    @post = Post.includes(:tags).friendly.find(params[:id])
  end

end