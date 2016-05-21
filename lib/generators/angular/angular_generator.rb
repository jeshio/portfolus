include ActionView::Helpers::TextHelper

class AngularGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :class_name, :type => :string

  def generate
    empty_directory "app/assets/javascripts/#{file_name}"
    template "factory.js", "app/assets/javascripts/#{file_name}/#{file_name}Factory.js"
    template "controller.js", "app/assets/javascripts/#{file_name}/#{file_name}Ctrl.js"
    template "list.html", "app/assets/javascripts/#{file_name}/_list.html"
  end

  private
  def file_name
    class_name.underscore
  end
end
