module UserSerializer
  class Base < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :user_name
  end
end
