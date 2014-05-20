module VkontakteHelper
  include ActionView::Helpers::TextHelper

  def repost_on_group_wall(post)
    require 'yaml'
    vk_params = YAML.load_file(File.join(Rails.root, 'config', 'application.yml'))[Rails.env]['vk']
    if vk_params
      vk = VkontakteApi::Client.new(vk_params['access_token'])
      #чтобы вместо http://localhost... добавлялась на стену реальная ссылка
      url = Rails.env =~ /production/ ? show_post_comments_url(post) : 'http://pogoda.yandex.ua'
      message = "#{post.subject}\r\n#{truncate(post.message.strip_tags, length: post.truncate_character)}\r\n\r\nУзнать подробнее на #{url}"
      response = vk.wall.post( owner_id: "-#{vk_params['group_id']}",
                               message: message,
                               from_group: vk_params['from_group'],
                               signed: vk_params['signed'])
      response['error'].blank? && response['post_id']
    end
  end

end