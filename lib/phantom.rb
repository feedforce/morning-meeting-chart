require 'phantomjs'
require 'rsvg2'
require 'mini_magick'

class ImageConverter
  class << self
    def exec
      File.write('sample.png', ImageConvert.svg_to_png(1, 1000, 700))
    end

    def svg_to_png(team_id, width, height)
      b = StringIO.new
      Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, width, height) do |surface|
        context = Cairo::Context.new(surface)
        context.render_rsvg_handle(svg(team_id))
        surface.write_to_png(b)
        surface.finish
      end

      return b.string
    end

    def svg(team_id)
      svg = Phantomjs.run('./lib/phantom.js', "#{root}/teams/#{team_id}")
      RSVG::Handle.new_from_data(svg)
    end

    def root
      'http://localhost:3000'
    end
  end
end
