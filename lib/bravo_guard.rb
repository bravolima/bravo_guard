module BravoGuard

  class PermissionDenied < StandardError; end
  class PermissionGranted < StandardError; end

end
require 'bravo_guard/model'
require 'bravo_guard/controller'

require 'bravo_guard/railtie'
