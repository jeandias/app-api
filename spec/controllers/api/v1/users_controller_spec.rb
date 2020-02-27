require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST api/v1/users#create" do
    context "with invalid params" do
      it "should respond with a list of errors" do
        post :create, { params: { user: { password: nil } } }
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to eq({
                                                  "error" => {
                                                    "password" => [
                                                      "can't be blank",
                                                      "is too short (minimum is 6 characters)",
                                                      "should have lower case and upper case words",
                                                      "should have at least 1 number",
                                                      "should have at least 1 symbol"
                                                    ]
                                                  }
                                                })
      end
    end
  end
end
