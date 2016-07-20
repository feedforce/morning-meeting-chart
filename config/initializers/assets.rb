# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# .js .css .html .jsonファイルはコンパイルしないようにする
precompile_target = lambda do |filename, path|
  puts filename
  path =~ /app\/assets/ && !%w(.js .css .html .json .eot .svg .ttf .woff .woff2).include?(File.extname(filename))
end
Rails.application.config.assets.precompile = [
  precompile_target,
  /(?:\/|\\|\A)application\.(css|js)$/
]

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
