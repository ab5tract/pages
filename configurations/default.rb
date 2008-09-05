module Pages
  module Configurations
    class Default < Waves::Configurations::Default
            
      resources do
        mount :image, :accepts => :image
        mount :media, :accepts => [ :css, :js ]
        mount :blog, :accepts => :rss
        
        mount true, [ :resource, { :rest => true } ], :as => :visitor
        mount :story, [ :name ], :as => :visitor
        mount :story, [], :as => :visitor
        
        mount true, [ 'admin', :resource, { :rest => true }], :as => :author
        mount :site, [ 'admin', { :rest => true } ]
        
      end
      
    end
  end
end