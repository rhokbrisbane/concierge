require 'spec_helper'

describe ResourceCategory do
  it { should validate_presence_of(:name) }

  it { should have_many(:resources) }

  describe '#to_s' do
    let(:category_name) { 'Weight group' }

    it 'returns the name' do
      subject.name = category_name
      expect(subject.to_s).to eql(category_name)
    end
  end
end
