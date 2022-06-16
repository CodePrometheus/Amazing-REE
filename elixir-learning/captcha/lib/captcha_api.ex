defmodule CaptchaApi do
  def captcha_name(phone) do
    "captcha_" <> phone
  end

  def new_captcha(phone, code) do
    {:ok, handler} = CaptchaHandler.start_link([phone, code])

    case :global.register_name(captcha_name(phone), handler) do
      :yes ->
        handler

      :no ->
        prev_handler = :global.whereis_name(captcha_name(phone))
        Process.exit(handler, :normal)
        prev_handler
    end
  end

  def verify(phone, code) do
    # undefined Or PID
    case :global.whereis_name(captcha_name(phone)) do
      :undefined ->
        :captcha_expired

      handler ->
        CaptchaHandler.verify(handler, phone, code)
    end
  end
end
