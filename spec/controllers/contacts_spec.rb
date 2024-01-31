require "rails_helper"

class Hash
  def json(parts)
    ary = parts.split(">") #tira o >
    ary.reduce(self) do |memo, key| #Divide a string 
      memo.fetch(key.to_s.strip) if memo #tira o espaço
    end
  end
end

describe ContactsController, type: :controller do 
  it 'request index return 200 OK' do
    request.accept = 'application/vnd.api+json' 
    get :index
    expect(response).to have_http_status(:ok)
  end

  it 'request index return 406 not_acceptable' do
    get :index
    expect(response).to have_http_status(:not_acceptable)
  end

  it 'GET /contacts/:id' do
    contact = Contact.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      birthdate: Faker::Date.between(from: 55.days.ago, to: 18.days.ago),
      kind: Kind.create!(
        description: "Amigo")
    )
    request.accept = 'application/vnd.api+json'
    get :show, params: { id: contact.id }
    response_body = JSON.parse(response.body)    

    expect(response_body.json('data > id')).to eq(contact.id.to_s)
    expect(response_body.json('data > type')).to eq('contacts')
    expect(response_body.json('data > attributes > name')).to eq(contact.name)

  end
end