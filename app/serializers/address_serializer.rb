class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city

  belongs_to :contact do 
    link(:related) {
      contact_url(object.contact_id)
    }
  end
end
