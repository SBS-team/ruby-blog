class SitemapUpdateJob
  @queue = :sitemap_updating

  def self.perform
    puts "\nFILE sitemap.xml.gz UPDATING..."
    require 'rake'
    app = Rake.application
    app.init
    app.load_rakefile
    app['sitemap:refresh:no_ping'].invoke
    app['sitemap:refresh:no_ping'].reenable
    puts "File sitemap.xml.gz was SUCCESSFULLY updated.\n---FINISH JOB---"
  end
end