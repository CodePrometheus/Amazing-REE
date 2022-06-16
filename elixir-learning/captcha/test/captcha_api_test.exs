defmodule CaptchaApiTest do
  use ExUnit.Case, async: true

  @phone "1"
  @code "1234"

  setup do
    {:ok, handler: CaptchaApi.new_captcha(@phone, @code)}
  end

  describe "#new_captcha" do
    test "create new captcha", %{handler: handler} do
      assert is_pid(handler)
    end

    test "duplicate call should returns the same handler", %{handler: handler} do
      handler_1 = CaptchaApi.new_captcha(@phone, @code)
      assert handler == handler_1
    end
  end

  describe "#verify" do
    test "should return :ok" do
      assert :ok == CaptchaApi.verify(@phone, @code)
    end

    test "should return :error" do
      assert :error == CaptchaApi.verify(@phone, @code <> @code)
    end

    test "should return :captcha_expired with mismatch phone" do
      assert :captcha_expired == CaptchaApi.verify(@phone <> @phone, @code)
    end

    test "should return :captcha_expired on the 4th call" do
      assert :ok == CaptchaApi.verify(@phone, @code)
      assert :error == CaptchaApi.verify(@phone, @code <> @code)
      assert :ok == CaptchaApi.verify(@phone, @code)
      assert :captcha_expired == CaptchaApi.verify(@phone, @code)
    end
  end
end
