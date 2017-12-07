defmodule ChoraleApi.Router do
	use Plug.Router
  
	plug(:match)
	plug(:dispatch)
  
	get("/", do: send_resp(conn, 200, "ChoraleAPI OK"))
	match(_, do: send_resp(conn, 404, "404, resource not found"))
  end
  
  