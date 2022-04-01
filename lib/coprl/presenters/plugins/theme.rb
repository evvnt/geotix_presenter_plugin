require_relative 'theme/evvnt_theme'
require_relative 'theme/selector'

module Coprl
  module Presenters
    module Plugins
      module Theme
        module DSLHelpers
          def rgb_color(color_code)
            EvvntTheme::COLORS.fetch(color_code) { raise(Errors::ParameterValidation, "Failed to locate color for: #{color_code}") }
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
            render.call :erb, 'theme_header', views: view_dir_theme(pom), locals: { theme: theme }
          end

          private



        end
      end
    end
  end
end
