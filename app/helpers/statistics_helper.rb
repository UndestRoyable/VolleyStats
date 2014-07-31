module StatisticsHelper
  @@inputs = ["zone"]
  @@calculates = {"reception_efficiency"=>["reception_total", "reception_errors"],
    "attack_efficiency"=>["attack_total","attack_errors","attack_blocks", "attack_points"],
    "won_lost"=>["points_total","block_points"]}
  @@percents = ["attack_efficiency", "reception_efficiency"]

	def player_field(field_name,player_model)
    f = "" 
    for i in @@calculates.keys do
      if(@@calculates[i].include?(field_name))
        f = i
        break
      end
    end

		render partial: "player_field", locals:{field_name:field_name, player_model:player_model, inputs:@@inputs, calculates:@@calculates, f:f, percents:@@percents}
	end
end
