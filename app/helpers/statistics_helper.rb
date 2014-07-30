module StatisticsHelper
	def player_field(field_name,player_model)

		render partial: "player_field", locals:{field_name:field_name, player_model:player_model}

	end
end
