include ActionView::Helpers::TextHelper
# TODO переделать в CoffeeScript

class AngularGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :class_name, :type => :string

  def generate
    empty_directory "app/assets/javascripts/#{file_name}"
    empty_directory "app/assets/javascripts/#{file_name}/tmpl"
    template "factory.js", "app/assets/javascripts/#{file_name}/#{file_name}Factory.js"
    template "controller.js", "app/assets/javascripts/#{file_name}/#{file_name}Ctrl.js"
    template "createController.js", "app/assets/javascripts/#{file_name}/create#{file_name.camelize}Ctrl.js"
    template "detailController.js", "app/assets/javascripts/#{file_name}/detail#{file_name.camelize}Ctrl.js"
    template "list.html", "app/assets/javascripts/#{file_name}/tmpl/_list.html"
    template "form.html", "app/assets/javascripts/#{file_name}/tmpl/_form.html"
    template "new.html", "app/assets/javascripts/#{file_name}/tmpl/_new.html"
    template "update.html", "app/assets/javascripts/#{file_name}/tmpl/_update.html"
    template "detail.html", "app/assets/javascripts/#{file_name}/tmpl/_detail.html"
  end

  private
  def file_name
    class_name.camelize(:lower)
  end

  def file_name_u
    class_name.underscore
  end
end
