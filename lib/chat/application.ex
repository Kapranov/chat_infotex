defmodule Chat.Application do
  @moduledoc false

  use Supervisor

  @doc """
  Starts the endpoint supervision tree.
  """

  @type name :: atom | {:global, term} | {:via, module, term}
  @type option :: {:name, name}
  @type strategy :: :one_for_one | :one_for_all | :rest_for_one
  @type init_option ::
          {:strategy, strategy}
          | {:max_restarts, non_neg_integer}
          | {:max_seconds, pos_integer}


  @options [port: 4000]
  @name __MODULE__

  @spec start_link([option | init_option]) ::
          {:ok, pid} | {:error, {:already_started, pid} | {:shutdown, term} | term}
  def start_link(opts), do: Supervisor.start_link(@name, :ok, opts)

  @spec init(atom) :: {:ok, tuple}
  def init(:ok) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Chat.Web.Router, options: @options)
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
