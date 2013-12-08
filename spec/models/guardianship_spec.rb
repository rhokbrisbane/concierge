require 'spec_helper'

describe Guardianship do
  it { should belong_to(:kid) }
  it { should belong_to(:guardians).class_name('User').with_foreign_key('user_id') }
end
