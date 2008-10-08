module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
      log :level => :debug
      host '127.0.0.1'
      port 3000
	    session :duration => 30.minutes, :path => './tmp/sessions'
      
      application do
        use ::Rack::ShowExceptions
        run ::Waves::Dispatchers::Default.new
      end


#      cache :servers =>"127.0.0.1"

      server Waves::Servers::Mongrel.new
      cache :dir => '/tmp'
    end
  end
end
