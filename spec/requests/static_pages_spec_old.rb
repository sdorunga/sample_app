require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject { page } #tells should that the subject is page so we do not reference it

  describe "Home page" do
    before { visit root_path} #can also be before(:each); applies this action before every other action so we do not
    #put visit _path before each element

    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector('title', text: full_title('Home')) }
	end

  describe "Help page" do
    before { visit help_path}

    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path}

    it { should have_selector('h1', text: 'About Us') }
  	it { should have_selector('title', text: full_title('About Us')) }
  end 
  	
  describe "Contact page" do
    before { visit contact_path} 
      
    it { should have_selector('h1', text: "Contact") }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  #Test that links are leading to appropriate pages
  it "should have proper links" do
    visit root_path
    click_link "About" 
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact" 
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Sign Up Now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end
end