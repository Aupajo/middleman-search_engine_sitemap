Feature: Middleman Search Engine Sitemap

  Background:
    Given a fixture app "basic-app"

  Scenario: Produce a valid sitemap
    Given a file named "config.rb" with:
      """
      set :url_root, 'http://example.com'
      activate :search_engine_sitemap
      ignore '/ignored.html'
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "sitemap.xml" should validate against the sitemap schema
    And the file "sitemap.xml" should contain the following xml:
      """
      <urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>
        <url>
          <loc>http://example.com/home.html</loc>
          <priority>0.5</priority>
          <changefreq>monthly</changefreq>
        </url>
        <url>
          <loc>http://example.com/about.html</loc>
          <priority>0.2</priority>
          <changefreq>monthly</changefreq>
        </url>
        <url>
          <loc>http://example.com/blog.html</loc>
          <priority>0.5</priority>
          <changefreq>daily</changefreq>
        </url>
      </urlset>
      """
    And the file "sitemap.xml" should not contain "http://example.com/ignored.html"
    And the file "sitemap.xml" should not contain "http://example.com/ignored-in-frontmatter.html"

  Scenario: Work with directory indexes
    Given a file named "config.rb" with:
      """
      set :url_root, 'http://example.com'
      activate :directory_indexes
      activate :search_engine_sitemap
      ignore '/ignored.html'
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "sitemap.xml" should contain the following xml:
      """
      <urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>
        <url>
          <loc>http://example.com/home/</loc>
          <priority>0.5</priority>
          <changefreq>monthly</changefreq>
        </url>
        <url>
          <loc>http://example.com/about/</loc>
          <priority>0.2</priority>
          <changefreq>monthly</changefreq>
        </url>
        <url>
          <loc>http://example.com/blog/</loc>
          <priority>0.5</priority>
          <changefreq>daily</changefreq>
        </url>
      </urlset>
      """
    And the file "sitemap.xml" should not contain "http://example.com/ignored/"
    And the file "sitemap.xml" should not contain "http://example.com/ignored-in-frontmatter/"

  Scenario: Support custom URL processing
   Given a file named "config.rb" with:
      """
      set :url_root, 'http://example.com'
      activate :directory_indexes
      activate :search_engine_sitemap, process_url: ->(url) { url.upcase }
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "sitemap.xml" should contain the following xml:
      """
      <urlset xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'>
        <url>
          <loc>HTTP://EXAMPLE.COM/HOME/</loc>
          <priority>0.5</priority>
          <changefreq>monthly</changefreq>
        </url>
      </urlset>
      """

  Scenario: Ignore resources based on exclude_if result
   Given a file named "config.rb" with:
      """
      set :url_root, 'http://example.com'
      activate :search_engine_sitemap,
        exclude_if: ->(resource) { resource.data.ignored_by_proc }
      ignore 'ignored.html'
      """
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "sitemap.xml" should not contain "http://example.com/ignored-by-proc.html"
