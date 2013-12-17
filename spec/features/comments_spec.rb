require 'spec_helper'

describe 'Comment' do
  context 'as an admin' do
    before do
      find_or_create_user(admin: true)
      authenticate
    end

    it 'index' do
      visit admin_comments_path
    end
  end
end
