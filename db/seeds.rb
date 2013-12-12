# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear DB
Tag.delete_all
Comment.delete_all
Post.delete_all
Admin.delete_all

# Create administrators
admin = Admin.create(username: "admin", nick: "administrator", email: "admin@ruby-blog.org", password: "password")
superadmin = Admin.create(username: "sadmin", nick: "super administrator", email: "intale.a@gmail.com", password: "password")

# Create posts with/without comments and tags
tags = []
5.times { |i| tags << Tag.create(name: "tag#{i}") }

post1 = admin.posts.create(status: false, subject: 'What’s new in Gemnasium?', message: 'You now can choose exactly which projects you want to monitor and which one you don’t care about. Gemnasium will still try to automatically add/remove projects when syncing with Github, but as soon as you manually start or stop monitoring a project, it won’t override your choice anymore. So you now can freely choose which projects you want to track, and drop the others. To make it more clear, we’ve also cleaned up the profile view and you’ll now only see the monitored projects there. This will drastically reduce the signal to noise ratio so that you can focus on what matters to you.')
post1.tags << [tags[0], tags[1], tags[2]]
Comment.create(author: "user1", content: "Nice article", post_id: post1.id)
Comment.create(author: "senior developer", content: ":)", post_id: post1.id)

post2 = superadmin.posts.create(status: false, subject: 'Should you upgrade Rails from 3.2.12 to 3.2.13 ?', message: 'We recommend you to not upgrade to Rails 3.2.13 and to wait for 3.2.14 to be released. But how to do so having in mind the 4 security breaches that still exists? Well, that’s simple, first of all, you might not be impacted by all of those issues and second, some monkey patches have been released to help you keep your application secure without upgrading. So keep calm, create a temporary hotfix branch until 3.2.14 is out and apply the patches you need.')
post2.tags << [tags[0], tags[3], tags[4]]
Comment.create(author: "senior developer", content: ":(", post_id: post2.id)

post3 = admin.posts.create(status: false, subject: 'How to create a dynamic sitemap using Ruby on Rails', message: '<h5>What is sitemaps and why make a good use of that</h5><p>Sitemaps are a very simple way to tell all search engines about pages in your website. Keeping it updated is always recommended if you want to people find your page in search engines like Google, Bing, Yahoo and others.Sometimes it helps the search engines to index pages which is not indexed by default.</p><p>It\'s basically a XML file describing all URLs in your page:</p><pre><code>&lt;urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"&gt;
  &lt;url&gt;
    &lt;loc&gt;http://www.stjhimy.com&lt;/loc&gt;
    &lt;priority&gt;1.0&lt;/priority&gt;
  &lt;/url&gt;
  &lt;url&gt;
    &lt;loc&gt;http://www.stjhimy.com/category/1&lt;/loc&gt;
    &lt;priority&gt;1.0&lt;/priority&gt;
  &lt;/url&gt;
&lt;/urlset&gt;
</code></pre>
<h5>Creating your dynamic sitemap with Ruby on Rails</h5><p>First thing we need to do is specify the URL of our sitemap in the routes.rb file:</p>
<pre><code>map.sitemap "/sitemap.:format",
     :controller =&gt; "home",
     :action =&gt; "sitemap",
     :conditions =&gt; { :method =&gt; :get }
</code></pre>
<p>As you can see, my sitemap URL is gonna be http://www.mysite.com/sitemap.xml</p><p>Now go to your desired controller and create the sitemap method and put all you want to show in your sitemap there. I\'m using a blog as example, so all I need are my posts and my categories:</p>
<pre><code>@posts = Post.all
@categories = Category.all
</code></pre>
<p>Now that we have all the logic done, we need to create our view to show that sitemap when some request riches http://www.mysite.com/sitemap.xml.We need to build a XML containing the 3 main nodes to make it a sitemap:</p>
<ul><li>loc - The URL of your page</li><li>priority - The priority of the indexing page process between 0 and 1</li><li>lasmod - Date of the last modification</li></ul>'
)
