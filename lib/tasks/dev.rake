namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    %x(rails db:drop) 
    %x(rails db:create) 
    %x(rails db:migrate)
    %x(rails dev:kinds)
    %x(rails dev:contacts)
    %x(rails dev:phones)
  end

  desc "Criar contato"
  task contacts: :environment do
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 55.days.ago, to: 18.days.ago),
        kind: Kind.all.sample
      )
    end
  end

  desc "Cria Kind"
  task kinds: :environment do
    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
  end

  desc "Criar Phone"
  task phones: :environment do
    Contact.all.each do |contact|
      rand(5).times do |i|
        Phone.create!(number:Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
  end
end

