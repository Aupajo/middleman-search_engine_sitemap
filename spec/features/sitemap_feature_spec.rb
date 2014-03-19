require 'spec_helper'
require 'nokogiri'

describe "Search engine sitemaps", :feature do
  include XmlHelpers

  it "produces a sitemap" do
    run_site 'dummy' do
      set :url_root, 'http://example.com'
      activate :search_engine_sitemap
    end

    visit '/sitemap.xml'
    
    schema = File.expand_path('../../../sitemap.xsd', __FILE__)
    doc = Nokogiri::XML(last_response.body)
    expect(doc).to validate_against_schema(schema)

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/home.html',
      'priority'   => '0.5',
      'changefreq' => 'monthly'
    )

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/about.html',
      'priority'   => '0.2',
      'changefreq' => 'monthly'
    )

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/blog.html',
      'priority'   => '0.5',
      'changefreq' => 'daily'
    )
  end

  it "works with directory indexes" do
    run_site 'dummy' do
      set :url_root, 'http://example.com'
      activate :directory_indexes
      activate :search_engine_sitemap
    end

    visit '/sitemap.xml'
    doc = Nokogiri::XML(last_response.body)

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/home/',
      'priority'   => '0.5',
      'changefreq' => 'monthly'
    )

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/about/',
      'priority'   => '0.2',
      'changefreq' => 'monthly'
    )

    expect(doc).to contain_node('url').with_children(
      'loc'        => 'http://example.com/blog/',
      'priority'   => '0.5',
      'changefreq' => 'daily'
    )
  end
end