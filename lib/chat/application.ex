defmodule Chat.Application do
  @moduledoc false

  require N2O
  use Application

  alias Chat.Web.Router

  @options [port: 4_000]

  def init(state, args), do: {:ok, state, args}

  def start(_, _) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: @options
      )
    ]
    Supervisor.start_link(children, strategy: :one_for_one, name: Chat.Supervisor)
  end
end
