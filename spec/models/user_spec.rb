require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :picture }
  it { is_expected.to validate_inclusion_of(:gender).in_array(['M', 'F']) }

  it { is_expected.to have_one(:address).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:address) }
end
