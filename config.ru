require 'rack'
require File.expand_path("../lib/barcode_dispatcher", __FILE__)

run BarcodeDispatcher::Middleware.builder