namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    
    puts "Resetando o Banco......"
    %x(rails db:drop) 
    %x(rails db:create) 
    %x(rails db:migrate)

    puts "[Populando Banco]"

    puts "Criando tipos de contato......"
    %x(rails dev:kinds)

    puts "Criando contatos......"
    %x(rails dev:contacts)

    puts "Criando Telefones......"
    %x(rails dev:phones)

    puts "Criando Endereços......"
    %x(rails dev:address)
    puts "[Finalizado]"
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
        Phone.create!(
          number:Faker::PhoneNumber.cell_phone, 
          contact: contact)
      end
    end
  end

  desc "Criar endereço"
  task address: :environment do
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
  end

end

