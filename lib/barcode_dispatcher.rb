require "bundler/setup"

module BarcodeDispatcher
  autoload :Base, 'barcode_dispatcher/base'
  autoload :Middleware, 'barcode_dispatcher/middleware'
end