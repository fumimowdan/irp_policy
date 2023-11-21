module Irp
  class SchoolSummary
    include ActiveModel::Model
    include ActionView::Helpers::TranslationHelper

    def initialize(form)
      @form = form
    end
    attr_reader :form

    delegate :errors, to: :form

    def rows
      single_field_steps.map(&method(:format_single_row))
    end

    private

    def single_field_steps
      Irp::School::StepFlow.form_steps(form)
    end

    def format_single_row(step_class)
      step = step_class.new(form)
      {
        key: { text: t("summary.#{step.answer.field_name}") },
        value: { text: step.answer&.formatted_value },
        actions: [
          {
            href: step.path,
            visually_hidden_text: step.class::ROUTE_KEY.tr("-", " "),
          },
        ],
      }
    end
  end
end
