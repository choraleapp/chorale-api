defmodule ChoraleApi.Supervisor do
	use Application

	def start(_type, _args) do
		import Supervisor.Spec
	  
		children = [
			  worker(Mongo, [[name: :mongo, database: "chorale", seeds: ["192.168.59.100:27017"], pool: DBConnection.Poolboy]]),
			  Plug.Adapters.Cowboy.child_spec(:http, ChoraleApi.Router, [], port: 8080)
		]
	  
		opts = [strategy: :one_for_one, name: ChoraleApi.Supervisor]
		Supervisor.start_link(children, opts)
	  end
end