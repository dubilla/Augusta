# Golfers: Script to import golfers
# Assumes count is under 1050 and result step is 50

(0 .. 1000).step(50) do |step|

  response = HTTParty.get('http://api.espn.com/v1/sports/golf/pga/athletes?apikey=dv58z289n3pf5yw4gxrpzrwq&offset=' + step.to_s)

  athletes = response["sports"].first["leagues"].first["athletes"]

  athletes.each do |a|
    player = Player.new(first_name: a["firstName"], last_name: a["lastName"], external_id: a["id"])
    player.save! if player.valid?
    puts a["firstName"] << " " << a["lastName"]
  end

  puts Player.count

end
