defmodule CaptchaApiTest.Helper do
  def spawn_captcha(caller, phone, code) do
    handler = CaptchaApi.new_captcha(phone, code)
    send(caller, {:spawn_captcha, phone, handler})
  end
end
