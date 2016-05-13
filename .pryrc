Hirb.enable

Pry.config.editor = 'nano'

# загатовки для консоли
class Object
  def switch_db(env)
    config = Rails.configuration.database_configuration
    raise ArgumentError, 'Invalid Environment' unless
      config[env].present?

   ActiveRecord::Base.establish_connection(config[env])
   Logger.new(STDOUT).info("Successfully changed to #{env} environment")
 end
end
