require "middleman-core"
require "builder"
require "middleman-search_engine_sitemap/version"

::Middleman::Extensions.register(:search_engine_sitemap) do
  require "middleman-search_engine_sitemap/extension"
  ::Middleman::SearchEngineSitemap::Extension
end
