require 'spec_helper'

describe Address do
  it { should belong_to(:addressable) }
  it { should validate_presence_of(:street1) }
  it { should validate_presence_of(:suburb) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:addressable) }


  describe '#to_s' do
    let(:address) { Address.new(street1: '7 Prospect St',
                                suburb: 'Fortitude Valley',
                                state: 'QLD',
                                country: 'Australia') }
    it 'formats address' do
      expect(address.to_s).to eql('7 Prospect St, Fortitude Valley, QLD, Australia')
    end
  end

  describe 'after create' do
    it 'looks up for coordinates' do
      address = Address.create(attributes_for(:address).merge(longitude: nil, latitude: nil))

      expect(address.latitude).to eql(40.7143528)
      expect(address.latitude).to eql(-74.0059731)
    end
  end
end
