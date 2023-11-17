module Irp
  class SchoolStepFlow
    # rubocop:disable Layout/HashAlignment
    STEPS = {
      ApplicationRouteStep::ROUTE_KEY  => ApplicationRouteStep,
    }.freeze
    # rubocop:enable Layout/HashAlignment

    class << self
      # include Rails.application.routes.url_helpers
      include Engine.routes.url_helpers

      def matches?(request)
        STEPS.key?(request.params[:name])
      end

      def current_step(form, requested_step_name)
        return if form.blank? && requested_step_name != ApplicationRouteStep::ROUTE_KEY
        return ApplicationRouteStep.new(Form.new) unless form

        STEPS.fetch(requested_step_name).new(form)
      end

      def next_step_path(step)
        return summary_path               if step.is_a?(EmploymentDetailsStep)
        return EmploymentDetailsStep.path if step.is_a?(PersonalDetailsStep)
        return PersonalDetailsStep.path   if step.is_a?(EntryDateStep)
        return EntryDateStep.path         if step.is_a?(VisaStep)
        return VisaStep.path              if step.is_a?(SubjectStep)
        return SubjectStep.path           if step.is_a?(StartDateStep)
        return StartDateStep.path         if step.is_a?(ContractDetailsStep)
        return ContractDetailsStep.path   if step.is_a?(SchoolDetailsStep)
        return StartDateStep.path         if step.is_a?(TraineeDetailsStep)
        return TraineeDetailsStep.path    if step.is_a?(ApplicationRouteStep) && step.form.trainee_route?
        return SchoolDetailsStep.path     if step.is_a?(ApplicationRouteStep) && step.form.teacher_route?
      end

      def previous_step_path(step)
        return PersonalDetailsStep.path   if step.is_a?(EmploymentDetailsStep)
        return EntryDateStep.path         if step.is_a?(PersonalDetailsStep)
        return VisaStep.path              if step.is_a?(EntryDateStep)
        return SubjectStep.path           if step.is_a?(VisaStep)
        return StartDateStep.path         if step.is_a?(SubjectStep)
        return TraineeDetailsStep.path    if step.is_a?(StartDateStep) && step.form.trainee_route?
        return ContractDetailsStep.path   if step.is_a?(StartDateStep) && step.form.teacher_route?
        return SchoolDetailsStep.path     if step.is_a?(ContractDetailsStep)
        return ApplicationRouteStep.path  if step.is_a?(TraineeDetailsStep)
        return ApplicationRouteStep.path  if step.is_a?(SchoolDetailsStep)
      end
    end
  end
end
