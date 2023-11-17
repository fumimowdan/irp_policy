module Irp
  class SchoolStepFlow
    # rubocop:disable Layout/HashAlignment
    STEPS = {
      SchoolVerifyStep::ROUTE_KEY => SchoolVerifyStep,
    }.freeze
    # rubocop:enable Layout/HashAlignment

    class << self
      # include Rails.application.routes.url_helpers
      include Engine.routes.url_helpers

      def matches?(request)
        STEPS.key?(request.params[:name])
      end

      def current_step(form, requested_step_name)
        return if form.blank? && requested_step_name != SchoolVerifyStep::ROUTE_KEY
        return SchoolVerifyStep.new(SchoolForm.new) unless form

        STEPS.fetch(requested_step_name).new(form)
      end

      def next_step_path(step)
        return BEST_PERSON.first.path if step.form.best_person.nil?

        source = select_path(step)
        index = source.index(step.class) + 1
        return summary_path if index >= source.size

        source[index].path
      end

      def previous_step_path(step)
        return if step.form.best_person.nil?

        source = select_path(step)
        index = source.index(step.class) - 1
        return if index < 0

        source[index].path
      end

      private

      def select_path(step)
        return BEST_PERSON if step.form.best_person?

        NOT_BEST_PERSON
      end

      BEST_PERSON = [
        SchoolVerifyStep,
        SchoolEmploymentStep,
        SchoolSubjectStep,
      ]

      NOT_BEST_PERSON = [
        SchoolVerifyStep,
        SchoolIdentifyBestPersonStep,
      ]
    end
  end
end
