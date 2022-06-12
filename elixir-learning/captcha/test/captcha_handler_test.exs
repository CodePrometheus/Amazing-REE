defmodule CaptchaHandlerTest do
  use ExUnit.Case, async: true

  @phone "1"
  @code "1234"

  setup do
    captcha_handler = start_supervised!({CaptchaHandler, [@phone, @code]})
    {:ok, handler: captcha_handler}
  end

  test "spawns captcha handle", %{handler: captcha_handler} do
    assert captcha_handler != nil
  end

  describe "sequential verify" do
    test "return :ok with matched phone and code", %{handler: captcha_handler} do
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
    end

    test "return :error with mismatched code", %{handler: captcha_handler} do
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
    end

    test "return :captcha_expired with mismatched phone", %{handler: captcha_handler} do
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone <> "1", @code)
    end

    test "still :ok with matched phone and code for 3 times", %{handler: captcha_handler} do
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
    end

    test "still :error with mismatched phone and code for 3 times", %{handler: captcha_handler} do
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
    end

    test "got :captcha_expired with matched phone and code after 3 times :ok", %{
      handler: captcha_handler
    } do
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone, @code)
    end

    test "got :captcha_expired with mismatched code after 3 times :error", %{
      handler: captcha_handler
    } do
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
    end

    test "verify with mixed cases", %{
      handler: captcha_handler
    } do
      assert :error = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone <> @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone <> @phone, @code)
      assert :ok = CaptchaHandler.verify(captcha_handler, @phone, @code)
      assert :captcha_expired = CaptchaHandler.verify(captcha_handler, @phone, @code <> @code)
    end
  end

  describe "verify with concurrency" do
    # @tag mustexec: true | mix test --only mustexec
    test "should got 3 :ok for 3 concurrent invoke", %{
      handler: captcha_handler
    } do
      assert [:ok, :ok, :ok] ==
               [
                 Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code) end),
                 Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code) end),
                 Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code) end)
               ]
               # allOf
               |> Task.await_many()
    end

    test "concurrent with mixed cases", %{
      handler: captcha_handler
    } do
      ret =
        [
          Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code) end),
          Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code <> @code) end),
          Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code) end),
          Task.async(fn -> CaptchaHandler.verify(captcha_handler, @phone, @code <> @code) end)
        ]
        |> Task.await_many()

      assert [:ok, :error, :ok, :captcha_expired] == ret
      assert [] == ret -- [:ok, :ok, :error, :captcha_expired]
    end
  end
end
