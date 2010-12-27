module RspecRailsMatchers
  module Validations
    module AcceptanceOf
      def validate_acceptance_of(attribute)
        Rspec::Matchers::Matcher.new :validate_acceptance_of, attribute do |_attr_|
          match do |model|
            if model.is_a?(Class)
              clazz = model
              model = Factory.build(:"#{clazz.name.underscore}")
            else
              clazz = model.class
            end

            model.send("#{_attr_}=", nil)
            model.invalid? && model.errors[_attr_].any?
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected => [ "%s to validate acceptance of %s", model, _attr_ ]
            )
          end
        end
      end
    end
  end
end
