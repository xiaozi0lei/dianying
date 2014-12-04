require 'rails_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title("虎 妞 网") }
  end

  describe "signup page" do
    
    before { visit sign_up_path }

    it { should have_content('Sign Up') }
  end

  describe "signup" do

    before { visit sign_up_path }

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        within("div#test_email") do
          fill_in "Email", with: "user@example.com"
        end
        within("div#test_passwd") do
          fill_in "Password", with: "foobar"
        end
        # when I change the label string from ":password_confirmation" to ":confirmation", then the label is "Confirmation", Capybara will find the "Confirmation" label and try to input "foobar" string to "Confirmation" field, but there is only "Password confirmation" field. So always pops `Unable to find field "Confirmation"`
        #fill_in "Confirmation", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
