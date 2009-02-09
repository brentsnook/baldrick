module Baldrick
  class Task
    def initialize(matcher, procedure)
      @matcher, @procedure = matcher, procedure
    end

    def run order
      if matches = @matcher.match(order[:what])
        all_arguments = matches[1..-1] << order
        accepted_arguments = all_arguments[0..(@procedure.arity - 1)]
        @procedure.call(*accepted_arguments)
      end
    end

  end
end