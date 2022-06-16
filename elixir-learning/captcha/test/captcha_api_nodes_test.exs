defmodule CaptchaApiNodeTest do
  use ExUnit.Case, async: true

  @phone "1"
  @code "1234"

  describe "spawn api on another" do
    test "spawn api" do
      nodes = LocalCluster.start_nodes("captcha_", 1)
      [node1 | _] = nodes

      # 当前进程 ID
      caller = self()

      Node.spawn(node1, CaptchaApiTest.Helper, :spawn_captcha, [caller, @phone, @code])
      assert_receive({:spawn_captcha, @phone, _}, 1000)

      assert :ok == CaptchaApi.verify(@phone, @code)
      assert :error == CaptchaApi.verify(@phone, @code <> @code)
    end
  end
end
