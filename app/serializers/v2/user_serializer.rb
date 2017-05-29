module V2
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :gender, :address
    attribute :picture, key: :picture_url

    def address
      return nil unless object.address.present?
      AddressSerializer.new(object.address)
    end

    class AddressSerializer < ActiveModel::Serializer
      attributes :street, :number, :neighborhood, :city, :region, :country, :zipcode
    end
  end
end
