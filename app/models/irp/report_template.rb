module Irp
  class ReportTemplate < ApplicationRecord
    validates(:file, presence: true)
    validates(:filename, presence: true)
    validates(:report_class, presence: true, uniqueness: true)
    validates(:config, presence: true)

    validate do |record|
      HomeOfficeReportConfigValidator.new(record).validate
    end

  end
end
