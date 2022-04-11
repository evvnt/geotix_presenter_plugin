require_relative 'theme/palette'
require_relative 'theme/selector'

module Coprl
  module Presenters
    module Plugins
      module Theme
        module DSLHelpers
          def rgb_color(color_code)
            Palette::COLORS.fetch(color_code) do
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
            theme = Theme::Selector.call(context: pom.send(:context))
            render.call :erb, 'theme_header', views: view_dir_theme(pom),
                        locals: { theme: theme, custom_font_family: custom_font_family(theme) }
          end

          def custom_font_family(theme)
            return unless theme&.font_family&.present?
            return unless theme.font_family != Palette::FONTS[:default]

            theme.font_family
          end
        end
      end
    end
  end
end
