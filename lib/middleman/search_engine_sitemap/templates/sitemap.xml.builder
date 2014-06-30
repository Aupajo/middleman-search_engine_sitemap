xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  resources_for_sitemap.each do |page|
    xml.url do
      xml.loc File.join(url_root, page.url)
      xml.lastmod File.mtime(page.source_file).iso8601
      xml.changefreq page.data.change_frequency || default_change_frequency
      xml.priority page.data.priority || default_priority
    end
  end
end
