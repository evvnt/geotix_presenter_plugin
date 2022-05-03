require_relative 'theme/palette'
require_relative 'theme/default_palette'

module Coprl
  module Presenters
    module Plugins
      module Theme
        module DSLHelpers
          def palette_color(color_code, theme = nil)
            return Palette.themed_palette_color(color_code, theme) if theme

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
            theme = prepare_theme(pom.context)
            render.call :erb, 'theme_header', views: view_dir_theme(pom),
                        locals: { theme: theme, palette: prepare_palette(theme) }
          end

          def prepare_theme(context)
            context[:current_theme].try(:call) || {}
          end

          def prepare_palette(theme)
            if theme
              Palette.new(theme[:primary_color], theme[:secondary_color])
            else
              DefaultPalette::COLORS
            end
          end
        end
      end
    end
  end
end
