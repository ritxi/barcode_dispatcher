$:.push File.expand_path("../barcode_dispatcher", __FILE__)
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'barcode_dispatcher'
  s.version = '0.1.1'
  s.date = '2012-04-08'

  s.description = "Rack middleware to serve barcodes"
  s.summary     = "Rack middleware to serve barcodes"

  s.authors = ["Ricard Forniol"]
  s.email = "ricard@forniol.cat"

  # = MANIFEST =
  s.files = `git ls-files`.split("\n")

  s.extra_rdoc_files = %w[COPYING]

  s.add_dependency 'rack', '>= 1.2.5'
  s.add_dependency 'rmagick', '>= 2.13.1'
  s.add_dependency 'barby', '>= 0.5.0'
  s.add_dependency 'activesupport', '>= 3.0.12'
  s.add_dependency 'prawn', '>= 0.12.0'

  s.require_paths = %w[lib]
  s.rubygems_version = '1.1.1'
end