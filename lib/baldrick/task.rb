module Baldrick
  class Task
    def initialize(matcher, procedure)
      @matcher, @procedure = matcher, procedure
    end

    def run order
      matches = @matcher.match order

      if matches
        all_arguments = matches[1..-1] << order
        accepted_arguments = all_arguments[0..(@procedure.arity - 1)]
        instance_eval {@procedure.call(accepted_arguments)}
      end
    end

  end
end