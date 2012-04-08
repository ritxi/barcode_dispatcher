# encoding: UTF-8
require 'rack'
require 'active_support/hash_with_indifferent_access'
module BarcodeDispatcher
  class Middleware
    MIME_TYPE = Rack::Mime.mime_type '.png'

    class << self
      def call(env)
        params = params_for(env)
        code = params.delete(:code)
        barcode = BarcodeDispatcher::Base.new(code, params)

        begin
          [200, {"Content-Type" => MIME_TYPE}, [barcode.to_png]]
        rescue => e
          [400, {"Content-Type" => "#{Rack::Mime.mime_type('.txt')}; charset=utf-8", "Content-Encoding" => 'UTF-8'}, ['Codi de barres no vàlid']]
        end
      end

      def builder(path='/barcode')
        Rack::Builder.new do
          map(path) do
            run Proc.new { |env| Middleware.call(env) }
          end
        end
      end

      def params_for(env)
        Rack::Request.new(env).params.
          merge(env['action_dispatch.request.path_parameters'] || {}).symbolize_keys
      end
    end
  end
end