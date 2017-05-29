require 'rspec/expectations'

module SerializerMatchers
  RSpec::Matchers.define :have_attribute do |field, value|
    match do |actual|
      return false unless actual[:data].present?
      return false unless actual[:data][:attributes].present?
      return false unless actual[:data][:attributes][field].present?
      actual[:data][:attributes][field] == value
    end

    failure_message do |actual|
      "expected #{actual} to have attribute #{field} with value #{value} inside data"
    end
  end

  RSpec::Matchers.define :have_id do |expected|
    match do |actual|
      return false unless actual[:data].present?
      return false unless actual[:data][:id].present?
      actual[:data][:id] == expected
    end

    failure_message do |actual|
      "expected #{actual} to have field id inside data with value of #{expected}"
    end
  end
end
