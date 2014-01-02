require 'spec_helper'

describe ResourceSerializer do
  let(:resource) { build :resource }

  subject { described_class.new(resource) }

  it 'returns the correct JSON' do
    expect(JSON.parse(subject.to_json)).to eql({
      'id'         => resource.id,
      'name'       => resource.name,
      'category'   => resource.category,
      'url'        => resource.url,
      'phone'      => resource.phone,
      'facebook'   => resource.facebook,
      'twitter'    => resource.twitter,
      'address_id' => nil,
      'address'    => nil
    })
  end
end
