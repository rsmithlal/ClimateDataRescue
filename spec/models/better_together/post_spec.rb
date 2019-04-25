require 'rails_helper'

RSpec.describe BetterTogether::Post, type: :model do
  let(:post) { build(:better_together_post) }
  subject { post }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do

  end

  describe 'ActiveModel validations' do

  end

  describe 'callbacks' do

  end
end
