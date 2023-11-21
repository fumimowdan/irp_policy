module Irp
  module School
    class StepController < ApplicationController
      before_action :claim_token, :current_step

      def new
        render(current_step.template)
      end

      def update
        service = Irp::UpdateForm.call(current_step, step_params)
        if service.success?
          update_session(current_step)
          redirect_to(StepFlow.next_step_path(current_step))
        else
          render(current_step.template)
        end
      end

      alias_method :create, :update

      private

      def claim_token
        return if params[:ct].blank?

        @claim_token = ClaimToken.find(params[:ct])
        redirect_to(invalid_link_path) if !@claim_token&.valid?

        session['irp_school_form_claim_id'] = @claim_token.claim.id
      end

      def current_claim
        @current_claim ||= Irp.claim_class.find_by(id: session['irp_school_form_claim_id'])
      end

      def current_step
        @step ||= StepFlow.current_step(current_school_form, params[:name], current_claim)
        redirect_to(invalid_link_path) unless @step
        @step
      end

      def step_params
        params.fetch(step_params_name, {}).permit(*@step.fields)
      end

      def step_params_name
        ['school', @step.class.name.demodulize.underscore].join('_')
      end

      def setup_invisible_captcha
        @add_invisible_captcha = true if current_step.form.new_record?
      end

      def update_session(step)
        session["irp_school_form_id"] = step.form.id
      end
    end
  end
end
