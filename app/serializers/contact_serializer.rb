class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate #,:author

  belongs_to :kind do 
    link(:related) {
      contact_kind_url(object.id)
    }
  end

  has_many :phones do 
    link(:related) {
      contact_phones_url(object.id)
    }
  end

  has_one :address do 
    link(:related) {
      contact_address_url(object.id)
    }
  end

  meta do 
    { 
      author: "Vinicius", 
      ano: 2024 
    }
  end

  def attributes(*args)
    h = super(*args)
    # pt-BR --> h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end

  # def author 
  #   "VINICIUS O CATS"
  # end

  #Dados sobre o proprio JSON
  
  #links por path
  # link(:self) { 
  #   contact_url(object.id) # Ou usar path
  # }
  
end
