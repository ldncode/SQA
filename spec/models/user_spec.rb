require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, user: user, question: question) }

  describe 'current user author?' do
    it 'is the author?' do
      expect(user).to be_author_of(answer)
    end

    it 'is not the author?' do
      expect(user1).to_not be_author_of(answer)
    end
  end
end
