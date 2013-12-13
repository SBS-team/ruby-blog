class SitemapUpdateJob
  @queue = :sitemap_updating

  def self.perform
    puts "Begin sitemap.xml update"
    require 'rake'
    app = Rake.application
    app.init
    # do this as many times as needed
    #app.add_import 'some/other/file.rake'
    # this loads the Rakefile and other imports
    app.load_rakefile
    app['sitemap:refresh:no_ping'].invoke
    app['sitemap:refresh:no_ping'].reenable
    puts "---FINISH---"
    puts "File sitemap.xml.gz was successfully updated."
  end
end