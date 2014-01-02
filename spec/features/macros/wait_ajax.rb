module AcceptanceMacros
  def wait_ajax
    wait_until { page.evaluate_script 'jQuery.active == 0' }
  end

  private

  def wait_until
    require 'timeout'

    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end
end
