require 'foundations/classic'
require 'layers/orm/filebase'
require 'lib/image'
require 'lib/response_mixin'

#require 'layers/cache/memcached'
require 'layers/caches/file'

module Pages
	include Waves::Foundations::Classic
  # => Cache testing code
  # include Waves::Layers::Cache::Memcached
  include Waves::Layers::Caches::File
end
