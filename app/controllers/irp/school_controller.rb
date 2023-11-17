module Irp
  class SchoolController < ApplicationController
    before_action :current_step

    def new
      render(current_step.template)
    end

    def update
      service = UpdateForm.call(current_step, step_params)
      if service.success?
        update_session(current_step)
        redirect_to(SchoolStepFlow.next_step_path(current_step))
      else
        render(current_step.template)
      end
    end

    alias_method :create, :update

    private

    def current_school_form
      @current_school_form ||= SchoolForm.find_by(id: session["irp_school_form_id"])
    end

    def current_step
      @step ||= SchoolStepFlow.current_step(current_form, params[:name])
      redirect_to(irp.root_path) unless @step
      @step
    end

    def step_params
      params.fetch(step_params_name, {}).permit(*@step.fields)
    end

    def step_params_name
      @step.class.name.demodulize.underscore
    end

    def setup_invisible_captcha
      @add_invisible_captcha = true if current_step.form.new_record?
    end

    def update_session(step)
      session["irp_school_form_id"] = step.form.id
    end
  end
end
