require "bundler/setup"
require 'active_support/core_ext/module/attribute_accessors'

module BarcodeDispatcher
  autoload :Base, 'barcode_dispatcher/base'
  autoload :Middleware, 'barcode_dispatcher/middleware'

  mattr_accessor :height
  @@height = 50

  mattr_accessor :labeled
  @@labeled = true

  mattr_accessor :barcode_type
  @@barcode_type = :EAN13
end