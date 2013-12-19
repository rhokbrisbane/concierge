require "spec_helper"

describe "Search API" do
  describe "given user1 (with an API token)" do
    let!(:user1) { create(:user) }
    let(:headers)  { { 'HTTP_AUTHORIZATION' => "Token token=\"#{user1.api_token}\"", 'Accept' => 'application/json' } }

    describe "user2- tagged and shared, and user3- tagged but not shared" do
      let!(:user2) { create(:user) }
      let!(:user3) { create(:user) }
      let!(:tag) { create(:tag) }

      before(:each) do
        user2.tags << tag
        user3.tags << tag

        user2.shared_users << user1
      end

      context "when the user provides a valid API token, and the relevant tag_id" do
        context "POST api/v1/search/people" do
          it "responds with 200" do
            post "api/v1/search/people", { tag_ids: [tag.id] }, headers

            expect(response).to be_success
          end

          it "responds with valid JSON" do
            post "api/v1/search/people", { tag_ids: [tag.id] }, headers

            response_body = %{
              {
                "search": [
                  {
                    "name": "#{user2.name}",
                    "email": "#{user2.email}",
                    "addresses": [],
                    "address_ids": []
                  }
                ]
              }
            }

            expect(JSON.parse(response.body)).to eql(JSON.parse(response_body))
          end
        end

        context "POST api/v1/search/resources" do
          it "responds with 200" do
            post "api/v1/search/resources", { tag_ids: [tag.id] }, headers

            expect(response).to be_success
          end

          it "responds with valid JSON" do
            post "api/v1/search/resources", { tag_ids: [tag.id] }, headers

            response_body = %{
              {
                "search": []
              }
            }

            expect(JSON.parse(response.body)).to eql(JSON.parse(response_body))
          end
        end
      end

      context "when the user does not provide a valid API token" do
        it "responds with 401" do
          post "api/v1/search/people", { tag_ids: [tag.id] }, nil

          expect(response.status).to eq(401)
        end
      end
    end
  end
end
