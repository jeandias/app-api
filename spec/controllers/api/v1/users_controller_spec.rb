require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST api/v1/users#create" do
    context "with invalid params" do
      it "should respond with a message" do
        post :validate_password, { params: { } }
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(400)
        response_body = {
          "error" => "Invalid parameters"
        }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with null params" do
      it "should respond with a list of errors" do
        post :validate_password, { params: { user: { password: nil } } }
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(200)
        response_body = {
          "error" => [
            "can't be blank",
            "is too short (minimum is 6 characters)",
            "should have lower case and upper case words",
            "should have at least 1 number",
            "should have at least 1 symbol"
          ],
          "strength" => nil
        }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with numbers only" do
      it "should respond with a list of errors and strength WEAK" do
        post :validate_password, { params: { user: { password: "123456" } } }
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(200)
        response_body = {
          "error" => [
            "should have lower case and upper case words",
            "should have at least 1 symbol",
            "This password is blacklisted"
          ],
          "strength" => "WEAK"
        }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "without at least 1 symbol" do
      it "should respond with a list of errors and strength OK" do
        post :validate_password, { params: { user: { password: "Abc456" } } }
        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(200)
        response_body = {
          "error" => ["should have at least 1 symbol"],
          "strength" => "OK"
        }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end

    context "with valid params" do
      it "should respond with user object and strength STRONG" do
        post :validate_password, { params: { user: { password: "Abc!456" } } }

        expect(response.content_type).to eq "application/json; charset=utf-8"
        expect(response.status).to eq(200)
        response_body = {
          "user" => {
            "created_at" => nil,
            "id" => nil,
            "password" => "Abc!456",
            "updated_at" => nil,
            "username"=> nil
          },
          "error" => [],
          "strength" => "STRONG"
        }
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end
  end
end
