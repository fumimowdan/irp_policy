require "irp/version"
require "irp/engine"
require "irp/claim_adapter"
require "irp/admin_tasks_presenter"
require "irp/eligibility_admin_answers_presenter"

module Irp
  mattr_accessor :claim_class
  mattr_accessor :task_class
  mattr_accessor :school_class
  mattr_accessor :config_class
  mattr_accessor :award_amount
  mattr_accessor :admin_base_controller_class
  mattr_accessor :claim_mailer_class
  mattr_accessor :claim_token_passphrase
  mattr_accessor :claim_token_salt


  def self.claim_class
    @@claim_class.constantize
  end

  def self.task_class
    @@task_class.constantize
  end

  def self.school_class
    @@school_class.constantize
  end

  def self.config_class
    @@config_class.constantize
  end

  def self.admin_base_controller_class
    @@admin_base_controller_class.constantize
  end

  def self.claim_mailer_class
    @@claim_mailer_class.constantize
  end

  extend ClaimAdapter
end
