require_relative 'theme/palette'
require_relative 'theme/default_palette'

module Coprl
  module Presenters
    module Plugins
      module Theme
        module DSLHelpers
          def palette_color(color_code, theme = nil)
            return Palette.palette_color(color_code, theme) if theme

            DefaultPalette::COLORS.fetch(color_code) do
              raise(Errors::ParameterValidation, "Failed to locate color for: #{color_code}")
            end
          end
        end

        module WebClientComponents
          def view_dir_theme(_pom)
            File.join(__dir__, '../../../..', 'views', 'components')
          end

          # The string returned from this method will be added to the HTML header section of the page layout
          # It will be called once for the page.
          # The pom is passed along with the sinatra render method.
          def render_header_theme(pom, render:)
            render.call :erb, 'theme_header', views: view_dir_theme(pom), locals: { theme: pom.context[:theme] || {} }
          end
        end
      end
    end
  end
end
