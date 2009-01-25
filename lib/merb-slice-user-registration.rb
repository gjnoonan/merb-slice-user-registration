if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "merb-slice-user-registration/merbtasks", "merb-slice-user-registration/slicetasks", "merb-slice-user-registration/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :merb-slice-user-registration
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_slice_user_registration][:layout] ||= :merb_slice_user_registration
  
  # All Slice code is expected to be namespaced inside a module
  module MerbSliceUserRegistration
    
    # Slice metadata
    self.description = "MerbSliceUserRegistration is a chunky Merb slice!"
    self.version = "0.0.1"
    self.author = "Your Name"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbSliceUserRegistration)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_slice_user_registration_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.match('/index(.:format)').to(:controller => 'main', :action => 'index').name(:index)
      scope.match('/').to(:controller => 'main', :action => 'index').name(:home)
      # enable slice-level default routes by default
      scope.default_routes
    end
    
  end
  
  # Setup the slice layout for MerbSliceUserRegistration
  #
  # Use MerbSliceUserRegistration.push_path and MerbSliceUserRegistration.push_app_path
  # to set paths to merb-slice-user-registration-level and app-level paths. Example:
  #
  # MerbSliceUserRegistration.push_path(:application, MerbSliceUserRegistration.root)
  # MerbSliceUserRegistration.push_app_path(:application, Merb.root / 'slices' / 'merb-slice-user-registration')
  # ...
  #
  # Any component path that hasn't been set will default to MerbSliceUserRegistration.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbSliceUserRegistration.setup_default_structure!
  
  # Add dependencies for other MerbSliceUserRegistration classes below. Example:
  # dependency "merb-slice-user-registration/other"
  
end