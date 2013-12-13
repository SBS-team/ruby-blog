SitemapGenerator::Sitemap.default_host = "http://is-valid.org"
# if change this path crashed sitemap tab content in admin panel
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.include_root = false

SitemapGenerator::Sitemap.create do
  add root_path, :lastmod => false, :priority => 1.0, :changefreq => false
  Post.where(:status => false).order(:updated_at).reverse_order.find_in_batches do |group|
    group.each do |post|
      add show_post_comments_path(post), :lastmod => false, :priority => 0.8, :changefreq => false
    end
  end
end

