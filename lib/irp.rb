require "irp/version"
require "irp/engine"

module Irp
  mattr_accessor :claim_class
  mattr_accessor :task_class
  mattr_accessor :school_class
  mattr_accessor :config_class

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
end
