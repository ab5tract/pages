module Pages
  module Resources
    class Map
      include Waves::Resources::Mixin
      
      # default to story if nothing else matches
      on( true ) { to( :story ) }
      
      # special URL just for login and authenticating
      on( [ :get, :post ], [ 'login' ] ) { to( :site ) }
      
      # another url for accessing admin page and updating site info
      on( [ :get, :post ], [ 'admin' ] ) { to( :site ) }

      # otherwise assume we are matching against a resource
      on( true, [ :resource, { :rest => true } ] ) { to( captured.resource ) }

      # before anything else, check the accepts headers and route accordingly
      on( :get, true, :accept => :image ) { to( :image ) }
      on( :get, true, :accept => [ :css, :javascript ] ) { to( :media ) }
      on( :get, true, :accept => :rss ) { to( :blog ) }
      
      private
      
    end
  end
end