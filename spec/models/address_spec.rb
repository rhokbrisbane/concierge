require 'spec_helper'

describe Address do
  it { should belong_to(:addressable) }
  it { should validate_presence_of(:street1) }
  it { should validate_presence_of(:suburb) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:addressable) }

  describe '#to_s' do
    let(:address) { build :ne_address }
    it 'formats address' do
      expect(address.to_s).to eql('7 Prospect St, Fortitude Valley, Queensland, Australia')
    end
  end

  describe '#save' do
    it 'calculates geolocation' do
      address = Address.create(attributes_for :ne_address)
      expect(address.reload.coordinates).to eql([40.7143528, -74.0059731])
    end
  end
end

