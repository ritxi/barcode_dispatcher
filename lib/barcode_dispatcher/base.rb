require 'barby'
require 'barby/outputter/rmagick_outputter'
require 'rvg/rvg'
autoload :Prawn, 'prawn'

module BarcodeDispatcher
  class Base
    include Magick
    attr_accessor :height, :margin, :code

    class << self
      def generate(code, options = {})
        self.new(code, options).to_png
      end
    end

    def initialize(code, params = {})
      @code = code
      @labeled = BarcodeDispatcher.labeled
      @height = BarcodeDispatcher.height
      @margin = 0
    end

    def labeled?
      @labeled
    end

    def to_rmagick
      barcode.to_image(height: height, margin: margin)
    end

    def to_png
      labeled? ? labeled : barcode.to_png(height: height, margin: margin)
    end

    def to_pdf
      ::Prawn::Images::PNG.new(to_png)
    end

    private
    def to_rvg_image
      RVG::Image.new(to_rmagick)
    end

    # labeled, barcode, code_with_format
  end
end