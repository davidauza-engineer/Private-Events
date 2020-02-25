require 'rails_helper'

RSpec.describe 'User model', type: :model do
  describe 'validations' do
    let(:test_user) { User.new(name: 'Example', email: 'user@user.com') }
    let(:user_comparison) { User.new(name: 'Compare', email: 'compare@user.com') }

    it 'user without name is invalid' do
      test_user.name = nil
      expect(test_user.valid?).to eq(false)
    end

    it 'short name is invalid' do
      test_user.name = 'a'
      expect(test_user.valid?).to eq(false)
    end

    it 'too long name is invalid' do
      test_user.name = 'a'*51
      expect(test_user.valid?).to eq(false)
    end

    it 'repeated name is invalid' do
      user_comparison.name = 'Example'
      user_comparison.save
      expect(test_user.valid?).to eq(false)
    end
  end
end