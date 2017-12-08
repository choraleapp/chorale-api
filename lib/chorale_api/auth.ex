defmodule ChoraleApi.Auth do
	def check(username,token) do
		
	end

	def check_pwd(username,password_hash) do
		#Mongo.insert_one(:mongo, "users", %{username: username,email: email,password_hash: password_hash}, pool: DBConnection.Poolboy)
	end

	def create_user(username,email,password_hash) do
		usernametk=(Mongo.find(
			:mongo, 
			"users", 
			%{
				"$or" =>[
					%{username: username}
				]
			}, 
			limit: 2, 
			pool: DBConnection.Poolboy
		)|> Enum.to_list)==[]
		emailtk=(Mongo.find(
			:mongo, 
			"users", 
			%{
				"$or" =>[
					%{email: email}
				]
			}, 
			limit: 2, 
			pool: DBConnection.Poolboy
		)|> Enum.to_list)==[]
		case !(usernametk || emailtk) do
			true ->
				challenge=:crypto.strong_rand_bytes(16)|>Base.encode16(case: :lower)
				{status,_}=Mongo.insert_one(
					:mongo, 
					"users", 
					%{
						username: username,
						email: email,
						password_hash: password_hash, 
						verified: false,
						challenge: challenge
					}, 
					pool: DBConnection.Poolboy
				)
				case status do
					:ok -> 
						challenge_uri=Application.get_env(:chorale_api,:validation_url)<>challenge
						Mailer.Email.Plain.create|>
						Mailer.Email.Plain.add_from(Application.get_env(:chorale_api, :email))|>
						Mailer.Email.Plain.add_to(email)|>
						Mailer.Email.Plain.add_date(DateTime.to_iso8601(DateTime.utc_now()))|>
						Mailer.Email.Plain.add_subject("Welcome from ChoraleApp")|>
						Mailer.Email.Plain.add_body(
							"""
							This is a test to see if your email is real and belongs to you. Click on the link next line to validate your account\n
							"""<>challenge_uri
						)|>
						Mailer.send
						:ok
					_ -> :dberror
				end
			_ -> 
				cond do
					usernametk -> :badusername
					emailtk -> :bademail
				end
		end
	end

	def generate_token(username,password_hash,is_master) do
		
	end
	
	def verify_user(challenge) do
		{status,_}=Mongo.find_one_and_update(
			:mongo, 
			"users", 
			%{
				"$and" =>[
					%{challenge: challenge},
					%{verified: false}
				]
			}, 
			%{
				"$set": %{"verified": true}
			},
			limit: 2, 
			pool: DBConnection.Poolboy
		)
		case status do
			:ok -> :ok
			_ -> :error
		end
	end
	
	def verify_token(username,token,pin) do
		
	end
end