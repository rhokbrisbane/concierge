require 'spec_helper'

describe ResourceSerializer do
  let(:resource) { create :resource }

  subject { described_class.new(resource) }

  it 'returns the correct JSON' do
    expect(JSON.parse(subject.to_json)).to eql({
      'name'    => resource.name,
      'content' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit'
    })
  end
end
