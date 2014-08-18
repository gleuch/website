require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "index" do
    it "GET should succeed" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response).to render_template(:home)
    end

    it "POST should succeed" do
      post :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response).to render_template(:home)
    end

    it "should fail for xml" do
      expect{ get :index, format: :xml }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "show" do
    %w(about).each do |p|
      describe "page #{p}" do
        it "GET should succeed" do
          get :show, id: p
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(p)
        end

        it "POST should succeed" do
          post :show, id: p
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(p)
        end

        it "should fail for xml" do
          expect{ get :show, id: p, format: :xml }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
