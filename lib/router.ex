defmodule BlockchainService.Router do
    use Plug.Router
  
    plug :match
    plug :dispatch
    plug Plug.Parsers, parsers: [:urlencoded]
  
    post "/new" do
        {:ok, data, _conn} = read_body(conn)
        data = Poison.decode!(data)
        result = "#{BlockchainService.newchain(data["message"])}"
        :timer.sleep(5_000)
        send_resp(conn, 200, result)
    end

    post "/add" do
        {:ok, data, _conn} = read_body(conn)
        data = Poison.decode!(data)
        result = "#{BlockchainService.addblock(data["message"])}"
        :timer.sleep(5_000)
        send_resp(conn, 200, result)
    end

    match _ do
        send_resp(conn, 404, "Requested page not found!")
    end
  end