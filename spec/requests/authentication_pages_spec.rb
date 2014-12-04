require 'rails_helper'

RSpec.describe "Authentication", :type => :request do

  subject { page }

  describe "signin page" do
    before { visit sign_in_path }

    it { should have_content('Sign In') }
  end

 end
