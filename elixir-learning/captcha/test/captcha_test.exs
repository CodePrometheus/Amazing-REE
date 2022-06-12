defmodule CaptchaTest do
  use ExUnit.Case
  doctest Captcha

  @phone "1"
  @code "1234"

  test "create captcha" do
    assert %{phone: "1", code: "ok", remaining: 3} = Captcha.new("1", "ok")
  end

  defp with_captcha(_tags) do
    captcha = Captcha.new(@phone, @code)
    {:ok, captcha: captcha}
  end

  setup [:with_captcha]

  describe "#verify" do
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

  describe "#verify with remaining" do
    test "should decrease remaining with matched phone and code", %{captcha: captcha} do
      assert {:ok, %{remaining: 2} = _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should decrease remaining with mismatch code", %{captcha: captcha} do
      assert {:error, %{remaining: 2}} = Captcha.verify(captcha, @phone, @code <> @code)
    end

    test "remaining should unchanged with unmatched phone", %{captcha: captcha} do
      assert {:captcha_expired, %{remaining: 3}} = Captcha.verify(captcha, @phone <> "1", @code)
    end
  end

  describe "#verify with one time left" do
    defp set_remaining(%{captcha: captcha}) do
      {:ok, captcha: %{captcha | remaining: 1}}
    end

    setup [:set_remaining]

    test "should decrease remaining with matched phone and code", %{captcha: captcha} do
      assert {:ok, %{remaining: 0} = _captcha} = Captcha.verify(captcha, @phone, @code)
    end

    test "should decrease remaining with mismatch code", %{captcha: captcha} do
      assert {:error, %{remaining: 0}} = Captcha.verify(captcha, @phone, @code <> @code)
    end

    test "remaining should unchanged with unmatched phone", %{captcha: captcha} do
      assert {:captcha_expired, %{remaining: 1}} = Captcha.verify(captcha, @phone <> "1", @code)
    end
  end

  describe "#verify with ran out remaining" do
    defp set_remaining_zero(%{captcha: captcha}) do
      {:ok, captcha: %{captcha | remaining: 0}}
    end

    setup [:set_remaining_zero]

    test "should return captcha_expired even with matched phone and code", %{captcha: captcha} do
      assert {:captcha_expired, ^captcha} = Captcha.verify(captcha, @phone, @code)
    end
  end
end
