rails g model city name:string

rails g model hall name:string city:references

rails g model scout first_name:string last_name:string email:string

rails g model country name:string

rails g model referee first_name:string last_name:string country:references

rails g model coach first_name:string last_name:string email:string country:references

rails g model team name:string number_players:integer coach:references

rails g model position name:string

rails g model player team:references first_name:string last_name:string number:integer position:references country:references

rails g model player_team player:references team:references from:datetime to:datetime

rails g model match date:datetime match_host:references match_guest:references duration:datetime

rails g model match_host team:references match:references result:integer set1_break1:integer set1_break2:integer set1_break3:integer set2_break1:integer set2_break2:integer set2_break3:integer set3_break1:integer set3_break2:integer set3_break3:integer 

rails g model match_guest team:references match:references result:integer set1_break1:integer set1_break2:integer set1_break3:integer set2_break1:integer set2_break2:integer set2_break3:integer set3_break1:integer set3_break2:integer set3_break3:integer 

rails g model match_referee match:references referee:references

rails g model match_set_score match:references set_number:integer host_score:integer guest_score:integer 

