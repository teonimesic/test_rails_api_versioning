module Api
  module V2
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name, :email, :picture, :gender
    end
  end
end
