defmodule Captcha do
  @moduledoc """
  Documentation for `Captcha`.
  """
  def new(phone, code) do
    %{phone: phone, code: code, remaining: 3}
  end

  defp decrease_remaining(%{remaining: remaining} = captcha) do
    %{captcha | remaining: remaining - 1}
  end

  def verify(%{phone: phone, code: code, remaining: remaining} = captcha, phone, code)
      when remaining > 0 do
    {:ok, decrease_remaining(captcha)}
  end

  def verify(%{phone: phone, remaining: remaining} = captcha, phone, _code)
      when remaining > 0 do
    {:error, decrease_remaining(captcha)}
  end

  def verify(captcha, _phone, _code) do
    {:captcha_expired, captcha}
  end
end
