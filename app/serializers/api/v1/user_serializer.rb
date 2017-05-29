module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name, :email, :picture
    end
  end
end
