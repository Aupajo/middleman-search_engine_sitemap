# Unmaintained

_I'm no longer maintaining this project, as I haven't used it in quite some time, and I've lost touch with what's happening inside the Middleman codebase. If you would like to take over as the maintainer, please open an Issue. Thanks!_

---

# Middleman Search Engine Sitemap

[![Build Status](https://travis-ci.org/Aupajo/middleman-search_engine_sitemap.png?branch=master)](https://travis-ci.org/Aupajo/middleman-search_engine_sitemap)
[![Code Climate](https://codeclimate.com/github/Aupajo/middleman-search_engine_sitemap.png)](https://codeclimate.com/github/Aupajo/middleman-search_engine_sitemap)
[![Dependency Status](https://gemnasium.com/Aupajo/middleman-search_engine_sitemap.svg)](https://gemnasium.com/Aupajo/middleman-search_engine_sitemap)
[![Gem
Version](https://badge.fury.io/rb/middleman-search_engine_sitemap.svg)](http://badge.fury.io/rb/middleman-search_engine_sitemap)

[Sitemaps](http://www.sitemaps.org/) are an open standard to tell search engines (such as Google) about each page on your site, how often they're updated, and how important each page is, relative to other pages on your site.

This project aims to simplify serving the sitemap XML file from your Middleman site, so that you can better instruct search engines on how to index your pages.

For more information on the standard itself, please visit http://www.sitemaps.org/.

## Installation

Add this line to your Middleman 4.x site's `Gemfile`:

```ruby
gem 'middleman-search_engine_sitemap'
```

If you're using Middleman 3.x, use version 1.3:

```ruby
gem 'middleman-search_engine_sitemap', '~> 1.3.0'
```

And then execute:

    bundle

## Usage

Place the following inside your `config.rb`:

```ruby
set :url_root, 'http://example.com'

activate :search_engine_sitemap
```

The sitemap will become available at [http://localhost:4567/sitemap.xml](http://localhost:4567/sitemap.xml).

## Priority and change frequency

Aside from helping identify which pages for search engines should crawl, you can also indicate which pages are more important than others, and how frequently they change.

By default, all pages have a priority of `0.5` (out of `1.0`) and a `monthly` change frequency.

You can change these values by passing in options to the `activate` directive:

```ruby
activate :search_engine_sitemap, default_priority: 0.5,
                                 default_change_frequency: "monthly"
```

You can override the priority or change frequency for a particular page by using frontmatter:

```erb
---
title: Blog
priority: 1.0
change_frequency: daily
---

Welcome to my blog! This page is particularly important, and changes often.
```

### Priority

A number between `0.0` and `1.0`, representing how important the page is, relative to other pages on your site.

The default value is `0.5`.

From [sitemaps.org](http://www.sitemaps.org/protocol.html):

> Valid values range from 0.0 to 1.0. **This value does not affect how your pages are compared to pages on other sites**–it only lets the search engines know which pages you deem most important for the crawlers.

> Please note that the priority you assign to a page is not likely to influence the position of your URLs in a search engine's result pages. Search engines may use this information when selecting between URLs on the same site, so you can use this tag to increase the likelihood that your most important pages are present in a search index.

> Also, please note that assigning a high priority to all of the URLs on your site is not likely to help you. Since the priority is relative, it is only used to select between URLs on your site.

### Change Frequency

Possible values are: `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, `never`.

The default value is `monthly`.

## Excluding pages

You can add a `hide_from_sitemap` attribute to your page's frontmatter to omit it from the sitemap:

```erb
---
title: My hidden page
hide_from_sitemap: true
---

Shh. Don't tell anyone I'm here.
```

If you would like to use a different frontmatter attribute from `hide_from_sitemap`, you can specify one in the extension options:

```ruby
activate :search_engine_sitemap, exclude_attr: 'hidden'
```

This would allow you to use `hidden: true` in place of `hide_from_sitemap: true`.

You can also use `exclude_if` to exclude pages based on more complex requirements. For example:

```ruby
# Exclude all pages which have a date that's after today
activate :search_engine_sitemap, exclude_if: ->(resource) {
  resource.data.date && resource.data.date > Date.today
}
```

The value passed into `exclude_if` can any object that responds to `call`.

## Customising the URL

Sometimes, you might want to alter the URLs that search engines will crawl:

```ruby
activate :search_engine_sitemap, process_url: -> (url) { url.chomp('/') }
```

The example above would remove a trailing slash from a URL.

The value passed into `process_url` can any object that responds to `call`.

## Contributing

1. Fork it ( http://github.com/Aupajo/middleman-search_engine_sitemap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
