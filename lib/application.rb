require 'foundations/classic'
require 'layers/orm/filebase'
require 'lib/image'
require 'lib/response_mixin'

#require 'layers/cache/memcached'
require 'layers/cache/file'

module Pages
	include Waves::Foundations::Classic
        #include Waves::Layers::Cache::Memcached
        include Waves::Layers::Cache::File
end

Waves << Pages
