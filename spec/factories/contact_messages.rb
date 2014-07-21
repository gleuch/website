FactoryGirl.define do
  factory :contact_message do
    session_id          { SecureRandom.hex(8) }
    subject             { ContactMessage.subjects.sample.first[0] }
    name                { Faker::Name.name }
    email               { Faker::Internet.email }
    phone               { Faker.numerify('(###)###-####') }
    message             { Faker::Lorem.sentence }
    ip_address          { Faker::Internet.ip_v4_address }
    browser             { 'Fake User Agent by gleu.ch' }
    referrer            { 'http://gleu.ch' }
  end
end