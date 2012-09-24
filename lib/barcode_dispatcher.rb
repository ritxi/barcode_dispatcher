require "bundler/setup"
require 'active_support/core_ext/module/attribute_accessors'

module BarcodeDispatcher
  autoload :Middleware, 'barcode_dispatcher/middleware'

  mattr_accessor :height
  @@height = 40

  mattr_accessor :labeled
  @@labeled = true

  mattr_accessor :barcode_type
  @@barcode_type = :Ean13

  mattr_reader :barcode_class

  class << self
    def load!
      autoload barcode_type, "barcode_dispatcher/#{barcode_type.to_s.downcase}"
      @@barcode_class = barcode_type.to_s.downcase
    end
  end
end