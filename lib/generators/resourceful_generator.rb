class ResourcefulGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_controller_files
    template('controller.rb',File.join('app/controllers', class_path, "#{file_name.pluralize}_controller.rb"))
  end

  def create_model_files
    template('model.rb',File.join('app/models', class_path, "#{file_name}.rb"))
  end

  def create_decorator_files
    template('decorator.rb',File.join('app/decorators', class_path, "#{file_name}_decorator.rb"))
  end

  def create_migration_files
    generate(:migration,"create_#{file_name.pluralize}")
  end

  def create_form_builder_files
    template('form_builder.rb',File.join('app/form_builders', class_path, "#{file_name}_form_builder.rb"))
  end

  def add_routes
    log :route, "#{file_name}"
    sentinel = /^\s+root\s+:to/m
    route_code="\n  resources :#{file_name.pluralize}, concenrs: %i(resourceful) \n"
    inject_into_file 'config/routes.rb', "#{route_code}", {before: sentinel, verbose: false, force: false}
  end
end
