require 'rails_helper'
require 'pry'

describe Api::V1::UserSerializer, type: :serializer do
  let(:user) { User.create name: 'stefano', email: 'a@a.com', picture: 'something' }
  let(:serializer) { described_class.new(user) }
  let(:adapter) { ActiveModelSerializers::Adapter.create(serializer) }
  subject(:serialization) { JSON.parse(adapter.to_json, symbolize_names: true) }

  it { is_expected.to have_id(user.to_param) }
  it { is_expected.to have_attribute(:name, 'stefano') }
  it { is_expected.to have_attribute(:email, 'a@a.com') }
  it { is_expected.to have_attribute(:picture, 'something') }
end
