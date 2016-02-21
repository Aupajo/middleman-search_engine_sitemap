Then /^the file "([^"]*)" should contain the following xml:$/ do |file, xml|
  target = File.join(expand_path("."), file)
  doc = File.open(target) { |f| f.read }
  doc.should contain_xml(xml)
end

Then /^the file "([^"]*)" should validate against the sitemap schema$/ do |file|
  schema = Pathname(__dir__) + '../../sitemap.xsd'
  target = File.join(expand_path("."), file)
  doc = File.open(target) { |f| Nokogiri::XML(f) }
  doc.should validate_against_schema(schema)
end
