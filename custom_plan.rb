require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test(*args)
    ENV['GUARD_RSPEC_RESULTS_FILE'] = 'tmp/rspec_guard_result' # can be anything matching Guard::RSpec :results_file option in the Guardfile
    super
  end
end

Zeus.plan = CustomPlan.new
