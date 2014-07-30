require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

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
      lambda { get :index, format: :xml }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "show" do
    %w(shaved-bieber greed what-color-is-the-internet twitter-fileshare dr-google).each do |p|
      describe "page #{p}" do
        it "GET should succeed" do
          get :show, id: p
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(p.underscore)
        end

        it "POST should succeed" do
          post :show, id: p
          expect(response).to be_successful
          expect(response).to have_http_status(200)
          expect(response).to render_template(p.underscore)
        end

        it "should fail for xml" do
          lambda { get :show, id: p, format: :xml }.should raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe "can have custom method options" do
      it "succeed for /all" do
        get :show, id: 'all'
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(response).to render_template('all')
        expect(assigns(:projects_list)).to match_array(I18n.t('projects.full_list'))
      end
    end
  end
end
