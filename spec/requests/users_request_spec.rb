require "rails_helper"
require_relative "../support/devise"

# Simple test for validating the email inp
RSpec.describe "Users", type: :request do

  describe "GET /users/sign_in" do
    it "returns http success" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET /users/sign_up" do
    it "returns http success" do
      get "/users/sign_up"
      expect(response).to have_http_status(:success)
    end
  end


end