defmodule Chat.Web.Router do
  @moduledoc false

  use Plug.Router

  @template "lib/chat/web/templates"

  plug Plug.Parsers,
    parsers: [:urlencoded],
    pass: ["text/*"]

  plug :match
  plug :dispatch

  get "/" do
    render(conn, "index.html")
  end

  get "/room1" do
    render(conn, "dashboard.html", room: 1)
  end

  get "/room2" do
    render(conn, "dashboard.html", room: 2)
  end

  get "/room3" do
    render(conn, "dashboard.html", room: 3)
  end

  match _ do
    send_resp(conn, 404, "Oops")
  end

  @spec render(%{status: integer()}, String.t(), list()) :: Plug.Cowboy.Conn.t
  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    send_resp(conn, (status || 200), body)
  end
end
