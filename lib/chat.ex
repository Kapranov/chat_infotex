defmodule Chat do
  @moduledoc """
  Documentation for `Chat`.
  """

  use Application

  @spec start(Application.start_type(), start_args :: term()) ::
          {:ok, pid()} | {:ok, pid(), Application.state()} | {:error, reason :: term()}
  def start(_type, _args), do: Chat.Application.start_link([])
end
