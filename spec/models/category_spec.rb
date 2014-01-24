require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }

  describe '#to_s' do
    let(:category_name) { 'Weight group' }

    it 'returns the name' do
      subject.name = category_name
      expect(subject.to_s).to eql(category_name)
    end
  end
end
