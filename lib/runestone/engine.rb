class Runestone::Engine < Rails::Engine
  config.runestone = ActiveSupport::OrderedOptions.new

  initializer :append_migrations do |app|
    unless app.root.to_s.match root.to_s
      config.paths["db/migrate"].expanded.each do |expanded_path|
        app.config.paths["db/migrate"] << expanded_path
      end
    end
  end
  
  initializer "runestone.set_configs" do |app|
    options = app.config.runestone

    Runestone.runner = options.runner if options.runner
    Runestone.dictionary = options.dictionary if options.dictionary
    Runestone.job_queue = options.job_queue if options.job_queue
    Runestone.typo_tolerances = options.typo_tolerances if options.typo_tolerances
  end
  
end