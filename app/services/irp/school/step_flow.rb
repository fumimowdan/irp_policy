module Irp
  module School
    class StepFlow
      # rubocop:disable Layout/HashAlignment
      STEPS = {
        VerifyStep::ROUTE_KEY             => VerifyStep,
        EmploymentStep::ROUTE_KEY         => EmploymentStep,
        SubjectStep::ROUTE_KEY            => SubjectStep,
        IdentifyBestPersonStep::ROUTE_KEY => IdentifyBestPersonStep,
      }.freeze
      # rubocop:enable Layout/HashAlignment

      class << self
        # include Rails.application.routes.url_helpers
        include Engine.routes.url_helpers

        def matches?(request)
          STEPS.key?(request.params[:name])
        end

        def current_step(form, requested_step_name, claim)
          return if form.blank? && requested_step_name != VerifyStep::ROUTE_KEY
          return VerifyStep.new(SchoolForm.new(claim: claim)) unless form

          STEPS.fetch(requested_step_name).new(form)
        end

        def next_step_path(step)
          return BEST_PERSON_SEQ.first.path if step.form.best_person.nil?

          source = form_steps(step.form)
          index = source.index(step.class) + 1
          return school_summary_path if index >= source.size

          source[index].path
        end

        def previous_step_path(step)
          return if step.form.best_person.nil?

          source = form_steps(step.form)
          index = source.index(step.class) - 1
          return if index < 0

          source[index].path
        end

        def form_steps(form)
          return BEST_PERSON_SEQ if form.best_person?

          NOT_BEST_PERSON_SEQ
        end

        private

        BEST_PERSON_SEQ = [
          VerifyStep,
          EmploymentStep,
          SubjectStep,
        ]

        NOT_BEST_PERSON_SEQ = [
          VerifyStep,
          IdentifyBestPersonStep,
        ]
      end
    end
  end
end
