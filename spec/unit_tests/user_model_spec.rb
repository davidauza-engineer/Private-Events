require 'rails_helper'

RSpec.describe 'User model', type: :model do
  let(:test_user) { User.new(name: 'Example', email: 'user@user.com') }
  let(:another_user) { User.new(name: 'Compare', email: 'compare@user.com') }

  describe 'invalid name cases' do

    it 'user without name is invalid' do
      test_user.name = nil
      expect(test_user.valid?).to eq(false)
    end

    it 'short name is invalid' do
      test_user.name = 'a'
      expect(test_user.valid?).to eq(false)
    end

    it 'too long name is invalid' do
      test_user.name = 'a' * 51
      expect(test_user.valid?).to eq(false)
    end

    it 'repeated name is invalid' do
      another_user.name = 'Example'
      another_user.save
      expect(test_user.valid?).to eq(false)
    end
  end

  describe 'invalid email cases' do
    it 'rejects an user with empty email' do
      test_user.email = nil
      expect(test_user.valid?).to eq(false)
    end

    it 'rejects an user which email is too short' do
      test_user.email = 'a@a.c'
      expect(test_user.valid?).to eq(false)
    end

    it 'rejects an user which email is too long' do
      test_user.email = 'a' * 141
      expect(test_user.valid?).to eq(false)
    end

    it 'rejects an user which email is already used by other user' do
      another_user.save
      test_user.email = another_user.email
      expect(test_user.valid?).to eq(false)
    end

    it 'rejects an user with an email not properly formatted' do
      test_user.email = 'invalid@'
      expect(test_user.valid?).to eq(false)
    end
  end

  describe 'the valid case' do
    it 'accepts an user with valid name and email' do
      expect(test_user.valid?).to eq(true)
    end
  end
end