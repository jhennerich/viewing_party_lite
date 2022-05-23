# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password } 
    
    it 'stores the password as :password_digest' do
      user = User.create!(name: 'Billy', email: 'billy.jonson@gmail.com', password: 'skibbitybop', password_confirmation: 'skibbitybop')

      expect(user).to_not have_attribute(:password)
      expect(user).to_not have_attribute(:password_confirmation)

      expect(user.password_digest).to_not eq('skibbitybop')
    end
  end

  context 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:viewing_parties).through(:party_users) }
  end

  context 'instance methods' do
    it '.is_host?(party_id) returns true or false if the user is host' do
      user = User.create!(name: 'Brylan', email: 'brylan.gannon112@gmail.com', password: 'brylan', password_confirmation: 'brylan')
      user2 = User.create!(name: 'John', email: 'John.Hennerich@gmail.com', password: 'john', password_confirmation: 'john')
      party = ViewingParty.create!(movie_title: 'Mad Max', duration: 100, date: '2022/10/20', start_time: '7:00')

      PartyUser.create!(user_id: user.id, viewing_party_id: party.id, host: true)
      PartyUser.create!(user_id: user2.id, viewing_party_id: party.id)

      expect(user.is_host?(party.id)).to be true
      expect(user2.is_host?(party.id)).to be false
    end
  end
end
