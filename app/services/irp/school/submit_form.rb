module Irp
  module School
    class SubmitForm
      def self.call(...)
        service = new(...)
        return service unless service.valid?

        service.submit_form!
        service
      end

      def initialize(form)
        @form = form
        @success = false
      end
      attr_reader :form

      delegate :errors, to: :form

      def valid?
        form.errors.blank?
      end

      def success?
        @success
      end

      def submit_form!
        form.submit!
        @success = true
      end
    end
  end
end
