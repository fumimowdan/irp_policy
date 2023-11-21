module Irp
  class AdminTasksPresenter
    attr_reader :claim

    def initialize(claim)
      @claim = claim
    end

    def school_answers
      form = Irp::SchoolForm.find_by(claim_id: claim.id)
      return unless form

      [
        [
          "Has started employment ",
          form.employment_start_date,
        ],
        [
          "Is teaching xx for more than 50% of the time",
          form.subject_taught,
        ],
      ]
    end
  end
end
