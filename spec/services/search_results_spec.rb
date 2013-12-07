require 'spec_helper'

describe SearchResults do
  describe ".for" do
    context "when supplying no tags" do
      it "does not throw an error" do
        expect { SearchResults.for }.to_not raise_error
        expect { SearchResults.for(tags: []) }.to_not raise_error
      end

      it "returns a SearchResults object with empty people" do
        expect(SearchResults.for(tags: []).people).to be_empty
      end

      it "returns a SearchResults object with empty resources" do
        expect(SearchResults.for(tags: []).resources).to be_empty
      end
    end

    context "when searching for tags a,b" do
      let(:tag1) { create(:tag, name: 'a') }
      let(:tag2) { create(:tag, name: 'b') }
      let(:tag3) { create(:tag, name: 'c') }

      context "given users tagged 'a' and 'c'" do
        let(:user) { create(:user) }
        let(:user2) { create(:user) }

        before(:each) do
          user.tags << tag1
          user2.tags << tag3
        end

        it "returns a SearchResults object including the user tagged 'a'" do
          expect(SearchResults.for(tags: [tag1.id, tag2.id]).people).to include(user)
        end

        it "returns a SearchResults object not including the user tagged 'c'" do
          expect(SearchResults.for(tags: [tag1.id, tag2.id]).people).to include(user)
        end
      end

      it "returns a SearchResults object with empty resources" do
        expect(SearchResults.for(tags: []).resources).to be_empty
      end
    end
  end
end
