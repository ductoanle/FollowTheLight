require 'spec_helper'

describe "LayoutLinks" do
  render_views
  
  it 'should have a sign up page at /signup' do
    get '/signup'
    response.should have_selector('title', :content=>'Sign Up')
  end
end