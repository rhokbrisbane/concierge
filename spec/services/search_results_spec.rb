require 'spec_helper'

describe SearchResults do
  describe ".for" do
    context "when supplying no tags" do
      it "does not throw an error" do
        expect { SearchResults.for }.to_not raise_error
        expect { SearchResults.for(tag_ids: []) }.to_not raise_error
      end

      it "returns a SearchResults object with empty people" do
        expect(SearchResults.for(tag_ids: []).people).to be_empty
      end

      it "returns a SearchResults object with empty resources" do
        expect(SearchResults.for(tag_ids: []).resources).to be_empty
      end
    end

    context "given tags a, b and c" do
      let(:a) { create(:tag, name: 'a') }
      let(:b) { create(:tag, name: 'b') }
      let(:c) { create(:tag, name: 'c') }

      context "when user1 is tagged 'a' - not required, and 'b' - required" do
        let(:user1) { create :user, public: true }

        before do
          user1.taggings.create(tag: a)
          user1.taggings.create(tag: b, required: true)
        end

        context "and user2 is tagged 'c'" do
          let(:user2) { create :user, public: true }

          before do
            user2.tags << c
            user2.shared_users << user1
          end

          context "searching for tag a" do
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [a.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [b.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [c.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [a.id, b.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [a.id, c.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [b.id, c.id]) }

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
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [a.id, b.id, c.id]) }

            it "returns a SearchResults object including user1" do
              expect(result.people).to include(user1)
              expect(result.all).to include(user1)
            end

            it "returns a SearchResults object including user2" do
              expect(result.people).to include(user2)
              expect(result.all).to include(user2)
            end
          end

          context "searching for private users" do
            let(:user3)  { create :user, public: false }
            let(:result) { SearchResults.for(ability: Ability.new(user1), tag_ids: [a.id, b.id, c.id]) }

            before { user3.tags << c }

            it "returns a SearchResults object which does not include private users" do
              expect(result.people).to_not include(user3)
              expect(result.all).to_not include(user3)
            end
          end
        end
      end

      it "returns a SearchResults object with empty resources" do
        expect(SearchResults.for(tag_ids: []).resources).to be_empty
      end
    end
  end
end
