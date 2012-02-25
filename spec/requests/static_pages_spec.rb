require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject {page} #tells should that the subject is page so we do not reference it

  describe "Home page" do
    before { visit root_path} #can also be before(:each); applies this action before every other action so we do not
    #put visit _path before each element

    it should have_slector('h1', text: 'Sample App')
    

    it "should have the right title" do
  		page.should have_selector('title',
                    :text => "#{base_title} | Home")
	end
  end

  describe "Help page" do
    before { visit help_path}

    it "should have the h1 'Help'" do
      page.should have_slector('h1', text: 'Help')
    end

    it "should have the right title" do
  		page.should have_selector('title',
                    :text => "#{base_title} | Help")
	end
  end

  describe "About page" do
    before { visit about_path}

    it "should have the h1 'About Us'" do
      page.should have_slector('h1', text: 'About Us')
    end

  	it "should have the right title" do
  		page.should have_selector('title',
                    :text => "#{base_title} | About Us")
	end
  end 
  	
  describe "Contact page" do
    before { visit contact_path} 
      
    it "should have the h1 'Contact'" do
      page.should have_slector('h1', text: "Contact")
  end

    it "should have the right title" do
      page.should have_selector('title', :text => "#{base_title} | Contact")
  end
  end
end