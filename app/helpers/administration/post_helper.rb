module Administration::PostHelper
  def get_vk_params(params)
    @vk_params[params] if @vk_params
  end
end