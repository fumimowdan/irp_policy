require "govuk/components"

module Irp
  class Engine < ::Rails::Engine
    isolate_namespace Irp


    # initializer "irb.assets.precompile" do |app|
    #   app.config.assets.paths << Rails.root.join("node_modules")
    #   # app.config.assets.precompile += %w( admin.js admin.css )
    # end

   config.generators do |g|
      g.test_framework :rspec
    end
  end
end
