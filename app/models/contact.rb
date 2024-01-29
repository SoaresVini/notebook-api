class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones
  has_one :address
  #aceito atributos de Phone, posso destrui-lo
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  #def to_br
  #  { 
  #    name:  self.name,
  #    emial: self.email,
  #    birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #  }
  #end

  #def birthdate_br
  #  I18n.l(self.birthdate) unless self.birthdate.blank?
  #end

  #def as_json(options={})
    #super(options.merge(root: true, methods: [:kind, :birthdate_br], except: :kind_id))
  #end

  # def as_json(options={})
  #   h = super(options.merge(methods: [:kind]))
  #   h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #   h
  # end

  #def hello
  #  I18n.t('hello')
  #end

  # def i18n
  #   I18n.default_locale
  # end

end
