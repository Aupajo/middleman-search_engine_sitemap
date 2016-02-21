PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require 'middleman-core'
require 'middleman-core/step_definitions'
require 'test_xml'
require 'test_xml/spec'
require File.join(PROJECT_ROOT_PATH, 'features', 'support', 'xml_helpers')
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-search_engine_sitemap')
World(TestXml::MatcherMethods)
World(XmlHelpers)
