require_relative 'default_palette'

module Coprl
  module Presenters
    module Plugins
      module Theme
        class Palette
          attr_reader :primary_color, :secondary_color

          def initialize(primary_color:, secondary_color:)
            @primary_color = primary_color
            @secondary_color = secondary_color
          end

          def palette(color_code)
            locate_color(color_code)
          end

          def [](key)
            locate_color(key)
          end

          private

          def locate_color(color_code)
            if primary_color.present? && color_code.to_s.starts_with?('primary')
              return primary_color_hash[color_code] || DefaultPalette::COLORS[color_code]
            end

            if secondary_color.present? && color_code.to_s.starts_with?('secondary')
              return secondary_color_hash[color_code] || DefaultPalette::COLORS[color_code]
            end

            return DefaultPalette::COLORS[color_code] if DefaultPalette::COLORS[color_code].present?

            raise(Errors::ParameterValidation, "Failed to locate color for: #{color_code}")
          end

          def primary_color_hash
            @primary_color_hash ||= primary_color.present? ? generate_primary_color_hash : {}
          end

          def secondary_color_hash
            @secondary_color_hash ||= secondary_color.present? ? generate_secondary_color_hash : {}
          end

          def generate_primary_color_hash
            {
              primary10: darken_color(primary_color, 0.4),
              primary9: darken_color(primary_color, 0.5),
              primary8: darken_color(primary_color, 0.6),
              primary7: darken_color(primary_color, 0.7),
              primary6: primary_color,
              primary: primary_color,
              primary5: lighten_color(primary_color, 0.2),
              primary4: lighten_color(primary_color, 0.4),
              primary3: lighten_color(primary_color, 0.5),
              primary2: lighten_color(primary_color, 0.6),
              primary1: lighten_color(primary_color, 0.7),
            }
          end

          def generate_secondary_color_hash
            {
              secondary14: darken_color(secondary_color, 0.2),
              secondary13: darken_color(secondary_color, 0.3),
              secondary12: darken_color(secondary_color, 0.4),
              secondary11: darken_color(secondary_color, 0.5),
              secondary10: darken_color(secondary_color, 0.6),
              secondary9: darken_color(secondary_color, 0.7),
              secondary8: darken_color(secondary_color, 0.8),
              secondary7: darken_color(secondary_color, 0.9),
              secondary6: secondary_color,
              secondary: secondary_color,
              secondary5: lighten_color(secondary_color, 0.2),
              secondary4: lighten_color(secondary_color, 0.4),
              secondary3: lighten_color(secondary_color, 0.5),
              secondary2: lighten_color(secondary_color, 0.6),
              secondary1: lighten_color(secondary_color, 0.7)
            }
          end

          def darken_color(hex_color, amount)
            hex_color = hex_color.gsub('#','')
            rgb = hex_color.scan(/../).map {|color| color.hex}
            rgb[0] = (rgb[0].to_i * amount).round
            rgb[1] = (rgb[1].to_i * amount).round
            rgb[2] = (rgb[2].to_i * amount).round
            "#%02x%02x%02x" % rgb
          end

          # Amount should be a decimal between 0 and 1. Higher means lighter
          def lighten_color(hex_color, amount)
            hex_color = hex_color.gsub('#','')
            rgb = hex_color.scan(/../).map {|color| color.hex}
            rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
            rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
            rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
            "#%02x%02x%02x" % rgb
          end
        end
      end
    end
  end
end
