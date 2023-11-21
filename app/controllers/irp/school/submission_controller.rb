module Irp
  module School
    class SubmissionController < ApplicationController
      before_action :check_service_open!
      before_action :redirect_to_root_path_when_no_form, only: %i[summary create]

      def summary
        @summary = SchoolSummary.new(current_school_form)
      end

      def show
        render(:show)
      end

      def create
        service = SubmitForm.call(current_school_form)
        if service.success?
          update_session(service)
          redirect_to(school_submission_path)
        else
          @summary = SchoolSummary.new(service.form)
          render(:summary)
        end
      end

      private

      def update_session(service)
        session.delete("irp_school_form_id")
        session.delete('irp_school_form_claim_id')
      end

      def redirect_to_root_path_when_no_form
        redirect_to(root_path) unless current_school_form
      end
    end
  end
end
