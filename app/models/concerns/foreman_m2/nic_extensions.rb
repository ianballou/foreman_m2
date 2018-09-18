module ForemanM2
  module NicExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      delegate :hybrid_build?, :to => :host
    end

    # create or overwrite instance methods...

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name; end
    end
  end
end
