module Irp
  class SubmitForm
    def self.call(...)
      service = new(...)
      return service unless service.valid?

      service.submit_form!
      service
    end

    def initialize(form)
      @form = form
      @success = false
    end
    attr_reader :form, :claim

    delegate :errors, to: :form

    def valid?
      form.validate_completeness
      form.validate_eligibility
      form.errors.blank?
    end

    def success?
      @success
    end

    def submit_form!
      submit_claim
      send_applicant_email
      @success = true
    end

    private

    def submit_claim
      ActiveRecord::Base.transaction do
        create_eligibility
        create_claim
        create_claim_tasks
        delete_form
      end
    end

    def create_eligibility
      @eligibility = Irp.eligibility_class.create!(
        school_id:    form.school.id,
        policy_name:  "Irp",
        award_amount: 10_000
      )
    end

    def create_claim
      @claim = Irp.claim_class.create!(
        first_name:       form.given_name,
        middle_name:      form.middle_name,
        surname:          form.family_name,
        address_line_1:   form.address_line_1,
        address_line_2:   form.address_line_2,
        postcode:         form.postcode,
        date_of_birth:    form.date_of_birth,
        email_address:    form.email_address,
        has_student_loan: form.student_loan,
        academic_year:    form.academic_year,
        submitted_at:     Time.zone.now,
        reference:        Irp.claim_class.new.send(:unique_reference),
        eligibility:      @eligibility,
      )
    end

    def create_claim_tasks
      @tasks = [
        :home_office,
        :school_checks,
      ].each do |task_name|
        Irp.task_class.new(
          claim: claim,
          name: task_name,
          manual: true,
        ).save(validate: false)
      end
    end

    def delete_form
      form.destroy!
    end

    def send_applicant_email
      # GovukNotifyMailer
      #   .with(
      #     email: form.email_address,
      #     urn: claim.reference,
      #   )
      #   .irp_claim_submission
      #   .deliver_later
    end
  end
end
