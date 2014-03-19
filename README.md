# Middleman Search Engine Sitemap

[![Build Status](https://travis-ci.org/Aupajo/middleman-search_engine_sitemap.png?branch=master)](https://travis-ci.org/Aupajo/middleman-search_engine_sitemap)
[![Code Climate](https://codeclimate.com/github/Aupajo/middleman-search_engine_sitemap.png)](https://codeclimate.com/github/Aupajo/middleman-search_engine_sitemap)

Adds a sitemap.xml file (following the [sitemaps.org protocol](http://www.sitemaps.org/protocol.html)) to your Middleman site for major search engines including Google.

## Installation

Add this line to your Middleman site's Gemfile:

```ruby
gem 'middleman-search_engine_sitemap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-pagination

## Usage

Inside your `config.rb`:

```ruby
set :url_root, 'http://example.com'

activate :search_engine_sitemap
```

Pages have a priority of 0.5 and a change frequency of "monthly" by default.

You can change this by passing in options:

```ruby
activate :search_engine_sitemap, default_priority: 0.5,
                                 default_change_frequency: "monthly",
                                 sitemap_xml_path: "sitemap.xml"
```

You can override the priority or change frequency on page by using frontmatter:

```erb
---
title: Blog
priority: 1.0
change_frequency: daily
---

Welcome to my blog!
```

### On priority

From [sitemaps.org](http://www.sitemaps.org/protocol.html):

> Valid values range from 0.0 to 1.0. **This value does not affect how your pages are compared to pages on other sites**–it only lets the search engines know which pages you deem most important for the crawlers.

> Please note that the priority you assign to a page is not likely to influence the position of your URLs in a search engine's result pages. Search engines may use this information when selecting between URLs on the same site, so you can use this tag to increase the likelihood that your most important pages are present in a search index.

> Also, please note that assigning a high priority to all of the URLs on your site is not likely to help you. Since the priority is relative, it is only used to select between URLs on your site.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/middleman-search_engine_sitemap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
