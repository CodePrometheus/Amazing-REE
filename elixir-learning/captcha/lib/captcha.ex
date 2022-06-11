defmodule Captcha do
  @moduledoc """
  Documentation for `Captcha`.
  """
  def new(phone, code) do
    %{phone: phone, code: code}
  end

  def verify(captcha, phone, code) do
    if captcha.phone == phone and captcha.code == code do
      {:ok, captcha}
    else
      if captcha.phone == phone do
        {:error, captcha}
      else
        {:captcha_expired, captcha}
      end
    end
  end
end