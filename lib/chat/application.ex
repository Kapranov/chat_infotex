defmodule Chat.Application do
  @moduledoc false

  use Application

  @doc """
  Starts the endpoint supervision tree.
  """
  @impl true
  @spec start(Application.start_type(), start_args :: term()) ::
          {:ok, pid()} | {:ok, pid(), Application.state()} | {:error, reason :: term()}
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Chat.Web.Router, options: [port: port()])
    ]
    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec port() :: integer
  defp port() do
    System.get_env()
    |> Map.get("PORT", "4000")
    |> String.to_integer()
  end
end
