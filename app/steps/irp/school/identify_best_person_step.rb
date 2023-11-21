module Irp
  module School
    class IdentifyBestPersonStep < Irp::BaseStep
      BASE_PATH = :school_step_path
      ROUTE_KEY = "identify".freeze

      REQUIRED_FIELDS = %i[first_name last_name email_address].freeze

      OPTIONAL_FIELDS = %i[position].freeze

      def configure_step
        @question      = t("steps.school_identify_best_person.question")
        @question_type = :multi
      end

      def template
        "irp/step/identify"
      end
    end
  end
end
