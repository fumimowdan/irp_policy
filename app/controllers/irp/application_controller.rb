module Irp
  class ApplicationController < ActionController::Base
    default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

    def check_service_open!
      return if Irp.config_class.for("Irp").open_for_submissions?

      redirect_to(irp.closed_path)
    end

    def current_form
      @current_form ||= Form.find_by(id: session["irp_form_id"])
    end
  end
end
