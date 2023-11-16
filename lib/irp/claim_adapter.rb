module Irp
  module ClaimAdapter
    def locale_key
      'irp'
    end

    def routing_name
      PolicyConfiguration.routing_name_for_policy(Irp)
    end

    def short_name
      I18n.t("irp.policy_short_name")
    end
  end
end
