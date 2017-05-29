require 'rails_helper'

describe Api::V2::UserSerializer, type: :serializer do
  let(:address) { Address.new street: '1st Street', number: '123', city: 'New York', region: 'New York', country: 'USA', zipcode: '12345' }
  let(:user) { User.create name: 'stefano', email: 'a@a.com', picture: 'something', gender: 'M', address: address }
  let(:serializer) { described_class.new(user) }
  let(:adapter) { ActiveModelSerializers::Adapter.create(serializer) }
  subject(:serialization) { JSON.parse(adapter.to_json, symbolize_names: true) }

  it { is_expected.to have_id(user.to_param) }
  it { is_expected.to have_attribute(:name, 'stefano') }
  it { is_expected.to have_attribute(:email, 'a@a.com') }
  it { is_expected.to have_attribute(:"picture-url", 'something') }
  it { is_expected.to have_attribute(:gender, 'M') }

  it { is_expected.to have_sub_attribute(:address, :street, '1st Street') }
  it { is_expected.to have_sub_attribute(:address, :number, '123') }
  it { is_expected.to have_sub_attribute(:address, :city, 'New York') }
  it { is_expected.to have_sub_attribute(:address, :region, 'New York') }
  it { is_expected.to have_sub_attribute(:address, :country, 'USA') }
  it { is_expected.to have_sub_attribute(:address, :zipcode, '12345') }
end
