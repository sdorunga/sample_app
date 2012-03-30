require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject { page } #tells should that the subject is page so we do not reference it

  shared_examples_for "static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title))}
  end

  describe "Home page" do
    before { visit root_path} #can also be before(:each); applies this action before every other action so we do not
    #put visit _path before each element

    let(:heading) {'Sample App'}
    let(:page_title) {'Home'}

    it_should_behave_like "static pages"
	end

  describe "Help page" do
    before { visit help_path}

    let(:heading) {'Help'}
    let(:page_title) {'Help'}

    it_should_behave_like "static pages"
  end

  describe "About page" do
    before { visit about_path}

    let(:heading) {'About'}
    let(:page_title) {'About'}

    it_should_behave_like "static pages"
  end 
  	
  describe "Contact page" do
    before { visit contact_path} 
      
    let(:heading) {'Contact'}
    let(:page_title) {'Contact'}

    it_should_behave_like "static pages"
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
    click_link "sample app"
    page.should have_selector 'title', text: full_title('Home')
  end
end