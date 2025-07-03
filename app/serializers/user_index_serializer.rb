# ArraySerializer
class UserIndexSerializer < ActiveModel::Serializer
  attributes :id, :email, :sandbox, :iad_id
  has_many :subscriptions, key: :subscriptions

  class ServiceSerializer < ActiveModel::Serializer
    attributes :key
  end

  class SubscriptionSerializer < ActiveModel::Serializer
    attributes :created_at
    attributes :ended_at
    attributes :country
    attributes :plan
  end
end
