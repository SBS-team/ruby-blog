class Administration::SubscribesController < Administration::MainController

  def index
    @total_subs = Subscribe.order('created_at DESC').paginate(:per_page => 20, :page => params[:page])
  end

  def subscribe_month
    @month_subs = Subscribe.where('created_at >= ?', 30.days.ago).paginate(:per_page => 20, :page => params[:page])
  end

  def conf_subscribe
    @confirm_subs = Subscribe.where('confirmed_at IS NOT NULL').paginate(:per_page => 20, :page => params[:page])
  end

  def conf_sub_month
    @confirm_month_subs = Subscribe.where('confirmed_at >= ? AND confirmed_at IS NOT NULL', 30.days.ago).paginate(:per_page => 20, :page => params[:page])
  end

end