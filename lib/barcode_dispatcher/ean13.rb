require 'barcode_dispatcher/base'
require 'barby/barcode/ean_13'
module BarcodeDispatcher
  class Ean13 < Base
    BASE_HEIGHT = 25

    def code_with_format
      "#{barcode.checksum}  "+[].tap { |parts|
        code.clone.tap do |code_formated|
          2.times { parts << code_formated.slice!(0,6) }
        end
      }.join('  ')
    end

    private
    def image_height
      height + BASE_HEIGHT
    end

    def labeled
      RVG.dpi = 72
      image_height = height + BASE_HEIGHT
      rvg = RVG.new(114.px,image_height.px).preserve_aspect_ratio('xMidYMid', 'slice') do |canvas|
        canvas.background_fill = 'white'
        canvas.desc = "Barcode #{code}"
        square = RVG::Group.new do |square|
            square.rect(40, 12,0,0).
            styles(:stroke_width=>2, :fill=>'white')
        end
        canvas.use(to_rvg_image, 10, 10)
        canvas.use(square).translate(13, image_height-22)
        canvas.use(square).translate(61, image_height-22)
        canvas.text(0, image_height-10, code_with_format).
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