module Coprl
  module Presenters
    module Plugins
      module Theme
        class Selector
          attr_reader :context

          include AAA::Helpers::AuthenticateAuthorize
          include AppHelpers::ThemeHelper

          def self.call(*args)
            new(*args).call
          end

          def initialize(context:)
            @context = context
          end

          def call
            active_theme
          end
        end
      end
    end
  end
end
