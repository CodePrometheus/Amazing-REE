# Captcha

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `captcha` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:captcha, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/captcha>.

## Usage
~~~shell
iex.bat --name app1@127.0.0.1 --cookie mycookie -S mix
iex.bat --name app2@127.0.0.1 --cookie mycookie -S mix

Node.connect :"app1@127.0.0.1" # iex2
Node.list # [:"app1@127.0.0.1"]
~~~

~~~shell
# iex1
{:ok, captcha_pid} = CaptchaHandler.start_link(["1", "code"]) # {:ok, #PID<0.162.0>}
:global.register_name("nb", captcha_pid) # :yes

CaptchaHandler.verify(captcha_pid, "1", "code") # :ok
CaptchaHandler.verify(captcha_pid, "1", "code1") # :error
CaptchaHandler.verify(captcha_pid, "1", "code1") # :error
CaptchaHandler.verify(captcha_pid, "1", "code1") # :captcha_expired

:sys.get_state(captcha_pid) # %{code: "code", phone: "1", remaining: 0}

# ** (EXIT from #PID<0.153.0>) shell process exited with reason: killed
~~~

~~~shell
# iex2
Node.connect :"app1@127.0.0.1" # true or false
remote_pid = :global.whereis_name("nb") # PID<18294.162.0> or :undefined
GenServer.call(remote_pid, {:verify, "1", "code"}) # :captcha_expired

:sys.get_state(remote_pid) # %{code: "code", phone: "1", remaining: 0}

Process.exit(remote_pid, :kill) # true

app1 = :"app1@127.0.0.1"
Node.spawn(app1, fn ->
{:ok, c_id} = CaptchaHandler.start_link(["1", "code"])
:global.register_name("nb", c_id)
end) # PID<18294.162.0> iex2端主动
~~~