require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  before :all do
    # Test ill-formatted search item
    I18n.backend.store_translations :en, projects: {twitter_fileshare: {page_title: 'Test Bad Entry', tags: 1}}
  end

  describe "index" do
    describe "no query" do
      it "GET should succeed" do
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end

      it "POST should succeed" do
        post :index
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe "query with result" do
      {bieber: 4, all: 13}.each do |query,ct|
        it "GET should succeed" do
          get :index, q: query
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(:index)
          expect(assigns(:search_results)).not_to be_empty
          expect(assigns(:search_results).size).to eq(ct)
        end

        it "POST should succeed" do
          post :index, q: query
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(assigns(:search_results)).not_to be_empty
          expect(assigns(:search_results).size).to eq(ct)
        end
      end
    end

    describe "query with no result" do
      {omgwtfroflbbq: 0, xxx123: 0}.each do |query,ct|
        it "GET should succeed" do
          get :index, q: query
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(:index)
          expect(assigns(:search_results)).to be_empty
        end

        it "POST should succeed" do
          post :index, q: query
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(assigns(:search_results)).to be_empty
        end
      end
    end

    it "should fail for xml" do
      expect{ get :index, format: :xml }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "tags" do
    describe "tag with result" do
      ['ruby', 'html'].each do |tag|
        it "GET should succeed" do
          get :tags, id: tag
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(:tags)
          expect(assigns(:search_results)).not_to be_empty
          #expect(assigns(:search_results).size).to eq(ct)
        end

        it "POST should succeed" do
          post :tags, id: tag
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(:tags)
          expect(assigns(:search_results)).not_to be_empty
          #expect(assigns(:search_results).size).to eq(ct)
        end
      end
    end

    it "invalid item in index" do
      I18n.backend.store_translations :en, projects: {test_bad_i18n: {page_title: 'Test Tag', tags: 'rubyrubyruby'}}
      get :tags, id: 'ruby'
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(assigns(:search_results)).not_to be_empty
    end


    describe "tag with no result" do
      ['omgwtfroflbbq', 'xxx123'].each do |tag|
        it "GET should fail" do
          expect{ get :tags, id: tag }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "POST should fail" do
          expect{ get :tags, id: tag }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    it "should fail for xml" do
      expect{ get :index, id: 'ruby', format: :xml }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
