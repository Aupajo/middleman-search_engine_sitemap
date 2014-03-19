xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  sitemap.resources.select { |page| page.path =~ /\.html/ }.each do |page|
    xml.url do
      xml.loc File.join(url_root, page.path)
      xml.lastmod File.mtime(page.source_file).iso8601
      xml.changefreq page.data.change_frequency || default_change_frequency
      xml.priority page.data.priority || default_priority
    end
  end
end