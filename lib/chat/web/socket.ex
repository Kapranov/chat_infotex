defmodule Chat.Web.Socket do
  @moduledoc false

  require N2O

  def init(args) do
    {:ok,
      N2O.cx(module: Keyword.get(args, :module))
    }
  end

  def handle_in({"PING", _}, state), do: {:reply, :ok, {:text, "Aloha"}, state}
  def handle_in({"PING\n", _}, state), do: {:reply, :ok, {:text, "Aloha!"}, state}
  def handle_in({"XXX" = msg, _}, state), do: response(msg, state)
  def handle_in({"XXX\n" = msg, _}, state), do: response(msg, state)
  def handle_in({_, _}, state), do: {:reply, :ok, {:text, "PONG"}, state}
  def handle_info(msg, state), do: response_info(msg, state)

  defp response(msg, state) do
    case :n2o_proto.stream({:text, msg}, [:nitro_n2o], state) do
      {:reply, {:binary, _}, _, state} ->
        {:reply, :ok, {:binary, msg}, state}
    end
  end

  defp response_info(msg, state) do
    case :n2o_proto.info(msg, [], state) do
      {:reply, {:binary, reply}, _, state} ->
        {:reply, :ok, {:binary, reply}, state}
    end
  end
end
