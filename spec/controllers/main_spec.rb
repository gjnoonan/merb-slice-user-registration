require File.dirname(__FILE__) + '/../spec_helper'

describe "MerbSliceUserRegistration::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { add_slice(:MerbSliceUserRegistration) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(MerbSliceUserRegistration::Main, :index)
    controller.slice.should == MerbSliceUserRegistration
    controller.slice.should == MerbSliceUserRegistration::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(MerbSliceUserRegistration::Main, :index)
    controller.status.should == 200
    controller.body.should contain('MerbSliceUserRegistration')
  end
  
  it "should work with the default route" do
    controller = get("/merb-slice-user-registration/main/index")
    controller.should be_kind_of(MerbSliceUserRegistration::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/merb-slice-user-registration/index.html")
    controller.should be_kind_of(MerbSliceUserRegistration::Main)
    controller.action_name.should == 'index'
  end
    
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(MerbSliceUserRegistration::Main, 'index')
    
    url = controller.url(:merb_slice_user_registration_default, :controller => 'main', :action => 'show', :format => 'html')
    url.should == "/merb-slice-user-registration/main/show.html"
    controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
    
    url = controller.url(:merb_slice_user_registration_index, :format => 'html')
    url.should == "/merb-slice-user-registration/index.html"
    controller.slice_url(:index, :format => 'html').should == url
    
    url = controller.url(:merb_slice_user_registration_home)
    url.should == "/merb-slice-user-registration/"
    controller.slice_url(:home).should == url
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(MerbSliceUserRegistration::Main, :index)
    controller.public_path_for(:image).should == "/slices/merb-slice-user-registration/images"
    controller.public_path_for(:javascript).should == "/slices/merb-slice-user-registration/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/merb-slice-user-registration/stylesheets"
    
    controller.image_path.should == "/slices/merb-slice-user-registration/images"
    controller.javascript_path.should == "/slices/merb-slice-user-registration/javascripts"
    controller.stylesheet_path.should == "/slices/merb-slice-user-registration/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    MerbSliceUserRegistration::Main._template_root.should == MerbSliceUserRegistration.dir_for(:view)
    MerbSliceUserRegistration::Main._template_root.should == MerbSliceUserRegistration::Application._template_root
  end

end