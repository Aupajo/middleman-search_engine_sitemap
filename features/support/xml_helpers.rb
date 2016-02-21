module XmlHelpers
  extend RSpec::Matchers::DSL

  matcher :validate_against_schema do |schema|
    match do |actual|
      xsd = Nokogiri::XML::Schema(schema.read)
      @validation_errors = xsd.validate(actual)
      @validation_errors.empty?
    end

    failure_message do |actual|
      num_errors = @validation_errors.length
      error_count = "#{num_errors} error#{'s' if num_errors > 1}"

      "expected XML to validate against #{schema}, got #{error_count}:\n" +
        @validation_errors.each_with_index.map do |error, i|
          "  #{i + 1}. #{error}"
        end.join("\n")
    end
  end
end
