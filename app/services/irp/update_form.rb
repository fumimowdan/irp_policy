module Irp
  class UpdateForm
    def self.call(...)
      service = new(...)
      return service unless service.valid?

      service.update_form!
      service
    end

    def initialize(step, params)
      @step = step
      @form = step.form
      @params = params
    end
    attr_reader :step, :form, :params

    def valid?
      step.update(**parsed_params)
Rails.logger.info("_____> #{step.valid?}, #{step.errors.inspect}")
      step.valid?
    end

    def success?

      Rails.logger.info("success?, #{step.errors.blank?}, #{step.errors.inspect}")
      step.errors.blank?
    end

    def update_form!
      Rails.logger.info("update_form!, #{parsed_params.inspect}")
      form.update(**parsed_params)
    end

    private

    def parsed_params
      @parsed_params ||= ParsedParams.new(params).execute
    end
  end
end
