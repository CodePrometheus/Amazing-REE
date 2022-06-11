defmodule CaptchaTest do
  use ExUnit.Case
  doctest Captcha

  @phone "1"
  @code "1234"

  test "create captcha" do
    assert %{phone: "1", code: "ok"} = Captcha.new("1", "ok")
  end

  describe "#verify" do
    defp with_captcha(_tags) do
      captcha = Captcha.new(@phone, @code)
      {:ok, captcha: captcha}
    end

    setup [:with_captcha]

    test "should return :ok with matched phone and code", %{captcha: captcha} do
      assert {:ok, _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should return :error with mismatched code", %{captcha: captcha} do
      assert {:error, _captcha} = Captcha.verify(captcha, @phone, @code <> @code)
    end
    test "should return :captcha_expired with mismatched phone", %{captcha: captcha} do
      assert {:captcha_expired, _captcha} = Captcha.verify(captcha, @phone <> "1", @code)
    end
  end
end
