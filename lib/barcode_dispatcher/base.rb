require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/rmagick_outputter'
require 'rvg/rvg'
autoload :Prawn, 'prawn'

module BarcodeDispatcher
  class Base
    include Magick
    attr_accessor :height, :margin, :code
    BASE_HEIGHT = 25

    class << self
      def generate(code, options = {})
        BarcodeDispatcher::Base.new(code, options).to_png
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

    def code_with_format
      "#{barcode.checksum}  "+[].tap { |parts|
        code.clone.tap do |code_formated|
          2.times { parts << code_formated.slice!(0,6) }
        end
      }.join('  ')
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

    def labeled
      RVG.dpi = 72
      image_height = height + BASE_HEIGHT
      rvg = RVG.new(114.px,image_height.px).preserve_aspect_ratio('xMidYMid', 'slice') do |canvas|
        canvas.background_fill = 'white'
        canvas.desc = "Barcode #{code}"

        canvas.use(to_rvg_image, 10, 10)
        canvas.text(0, image_height, code_with_format).
          styles(font_family: 'Arial', font_size: 12, fill: 'black', font_weight: 'normal', font_style: 'normal')
      end
      rvg.draw.tap { |img|
        img.format='PNG'
      }.to_blob
    end

    def barcode
      Barby::EAN13.new(code)
    end
  end
end