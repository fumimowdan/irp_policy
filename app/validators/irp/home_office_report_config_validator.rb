# Example config
# config:
#    {
#      worksheet_name: "Data",
#      header_mappings: {
#        "ID (Mandatory)"               => %w[reference],
#        "Full Name/ Organisation Name" => %w[first_name middle_name surname],
#        "DOB"                          => %w[date_of_birth],
#        "Nationality"                  => %w[nationality],
#        "Passport Number"              => %w[passport_number],
#      }
#    }
#

module Irp
  class HomeOfficeReportConfigValidator
    def initialize(record)
      @record = record
    end

    def validate
      validate_workbook
      validate_config_worksheet_name
      validate_worksheet
      validate_config_header_mappings
    end

    private

    attr_reader :record, :workbook

    def validate_workbook
      @workbook = ::RubyXL::Parser.parse_buffer(record.file.dup)
    rescue StandardError
      record.errors.add(:file, :ho_invalid)
    end

    def validate_worksheet
      return if workbook.blank?

      record.errors.add(:config, :ho_invalid_worksheet_name) if workbook[record.config.fetch(Report::WORKSHEET_NAME_KEY, nil)].blank?
    end

    def validate_config_worksheet_name
      record.errors.add(:config, :ho_missing_worksheet_name) if record.config.fetch(Report::WORKSHEET_NAME_KEY, nil).blank?
    end

    def validate_config_header_mappings
      record.errors.add(:config, :ho_missing_header_mappings) if record.config.fetch(Report::HEADER_MAPPINGS_KEY, nil).blank?
    end
  end
end
