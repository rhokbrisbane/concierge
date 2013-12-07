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

    context "given tags a, b and c" do
      let(:a) { create(:tag, name: 'a') }
      let(:b) { create(:tag, name: 'b') }
      let(:c) { create(:tag, name: 'c') }

      context "when user1 is tagged 'a' - not required, and 'b' - required" do
        let(:user1) { create(:user) }

        before(:each) do
          user1.taggings.create(tag: a)
          user1.taggings.create(tag: b, required: true)
        end

        context "and user2 is tagged 'c'" do
          let(:user2) { create(:user) }

          before(:each) do
            user2.tags << c
          end

          context "searching for tag a" do
            let(:result) { SearchResults.for(tags: [a.id]) }

            it "returns a SearchResults object not including user1" do
              expect(result.people).to_not include(user1)
              expect(result.all).to_not include(user1)
            end

            it "returns a SearchResults object not including user2" do
              expect(result.people).to_not include(user2)
              expect(result.all).to_not include(user2)
            end
          end

          context "searching for tag b" do
            let(:result) { SearchResults.for(tags: [b.id]) }

            it "returns a SearchResults object including user1" do
              expect(result.people).to include(user1)
              expect(result.all).to include(user1)
            end

            it "returns a SearchResults object not including user2" do
              expect(result.people).to_not include(user2)
              expect(result.all).to_not include(user2)
            end
          end

          context "searching for tag c" do
            let(:result) { SearchResults.for(tags: [c.id]) }

            it "returns a SearchResults object not including user1" do
              expect(result.people).to_not include(user1)
              expect(result.all).to_not include(user1)
            end

            it "returns a SearchResults object including user2" do
              expect(result.people).to include(user2)
              expect(result.all).to include(user2)
            end
          end

          context "searching for tags a, b" do
            let(:result) { SearchResults.for(tags: [a.id, b.id]) }

            it "returns a SearchResults object including user1" do
              expect(result.people).to include(user1)
              expect(result.all).to include(user1)
            end

            it "returns a SearchResults object not including user2" do
              expect(result.people).to_not include(user2)
              expect(result.all).to_not include(user2)
            end
          end

          context "searching for tags a, c" do
            let(:result) { SearchResults.for(tags: [a.id, c.id]) }

            it "returns a SearchResults object not including user1" do
              expect(result.people).to_not include(user1)
              expect(result.all).to_not include(user1)
            end

            it "returns a SearchResults object including user2" do
              expect(result.people).to include(user2)
              expect(result.all).to include(user2)
            end
          end

          context "searching for tags b, c" do
            let(:result) { SearchResults.for(tags: [b.id, c.id]) }

            it "returns a SearchResults object including user1" do
              expect(result.people).to include(user1)
              expect(result.all).to include(user1)
            end

            it "returns a SearchResults object including user2" do
              expect(result.people).to include(user2)
              expect(result.all).to include(user2)
            end
          end

          context "searching for tags a, b, c" do
            let(:result) { SearchResults.for(tags: [a.id, b.id, c.id]) }

            it "returns a SearchResults object including user1" do
              expect(result.people).to include(user1)
              expect(result.all).to include(user1)
            end

            it "returns a SearchResults object including user2" do
              expect(result.people).to include(user2)
              expect(result.all).to include(user2)
            end
          end
        end
      end

      it "returns a SearchResults object with empty resources" do
        expect(SearchResults.for(tags: []).resources).to be_empty
      end
    end
  end
end
