class SchedulerController < ApplicationController
	IDEALDATES=["1/1","1/2","1/3","1/4","1/5"]
	IDEALSTARTTIME=10.5
	IDEALENDTIME=18

	def respondToToken

		if params[:token].nil?
			@dates=IDEALDATES
			@s_time=IDEALSTARTTIME
			@e_time=IDEALENDTIME
			@name = "大江戸ハッカソン打ち上げパーティー"
			@description="大江戸ハッカソンの打ち上げです"
			@dates_id = [1,2,3,4,5]
			@saved_data = Hash.new { |hash, key| hash[key] = "0"*48 }
		else
			e = EventToken.where(:token => params[:token]).last
			poss = PossibleDate.where(:event_id => e.event_id, :user_id => e.user_id)

			dates_tmp = []
			time_tmp = []

			dates_id_tmp = {}

			e.event.event_dates.each { |d|
				date_tmp = Time.at(d.start)
				dates_tmp << date_tmp.strftime("%m/%d")
				if date_tmp.strftime("%M").to_i >= 30
					time_tmp << date_tmp.strftime("%H") + ".5"
				else
					time_tmp << date_tmp.strftime("%H")
				end

				dates_id_tmp[date_tmp.strftime("%m/%d")] = d.id

				date_tmp = Time.at(d.end)
				dates_tmp << date_tmp.strftime("%m/%d")
				if date_tmp.strftime("%M").to_i >= 30
					time_tmp << date_tmp.strftime("%H") + ".5"
				else
					time_tmp << date_tmp.strftime("%H")
				end

			}

			@dates=dates_tmp.uniq.sort
			@s_time=time_tmp.min.to_i
			@e_time=time_tmp.max.to_i
			@name=e.event.name
			@description=e.event.description

			@dates_id = []
			@dates.each { |d|
				@dates_id << dates_id_tmp[d]
			}

			@saved_data = Hash.new { |hash, key| hash[key] = "0"*48 }
			unless poss.empty?
				@dates.each_with_index { |d,i| 
					unless poss.find{ |p| p.event_date_id == dates_id_tmp[d]}.nil?
						@saved_data[i] = poss.find{ |p| p.event_date_id == dates_id_tmp[d]}.possible_time[@s_time*2..@e_time*2]
					else
						@saved_data[i][@s_time*2..@e_time*2]
					end
				}
			end

		end


		#@rows = (@e_time - @s_time) * 2
		#@cols = @dates.length - 1
		#@cellWidth = [780/(@cols+1),270].min
		#@cellHeight =[1200/(@rows+1),100].max
		#@unselectedColor = "rgb(180, 180, 180)"
		#@selectedColor = "rgb(80, 80, 80)"

		@rows = (@e_time - @s_time) * 2 - 1
		@cols = @dates.length - 1
		@cellWidth = [800/(@cols+1),270].min
		#@cellHeight =[1200/(@rows+1),100].max
		@cellHeight =[800/(@rows+1),80].max
		@unselectedColor = "#DCDDDD"
		@selectedColor = "#339933"
		@interestColor = "#586B29"

		render "scheduler/main"

	end

	def newTimes
		e = EventToken.where(:token => params[:token]).last
		p_dates = PossibleDate.where(:event_id => e.event_id, :user_id => e.user_id)
		bit = params[:isSelecting] ? "1":"0"

		param = params[:coordinates]
		d = Hash.new {|hash, key| hash[key] = []}
		param.each { |dates_id, date_times|
			d[dates_id] << date_times
		}

		possible_times = Hash.new { |hash, key| hash[key] = "0"*48 }
		p_dates.each { |p|
			possible_times[p.event_date_id] = p.possible_time
		}

		d.each { |date_id,date_times|
			date_times.each { |t|
				possible_times[date_id][t] = bit
			}
		}

		possible_times.each { |k,v|
			p = PossibleDate.where(:event_id => e.event_id,:user_id => e.user_id,:event_date_id => k).last
			if p.nil?
				PossibleDate.create(:event_id => e.event_id,:user_id => e.user_id,:event_date_id => k,:possible_time => v)
			else
				p.update_attribute(:possible_time, v )
			end
			#puts YAML::dump(p)
		}
		render json: params()

		# Prepare data and broadcast it via Websocket!
		#r = ((IDEALENDTIME - IDEALSTARTTIME) * 2).to_i
		#c = IDEALDATES.length
		#d = []
		#r.times do |i|
		#d << (1..c).map{rand(0..10)}
		#end
		#d = (1..r*c).map{rand(0..10)}
		#result = JSON.generate({rows: r, cols: c, data: d})
		#WebsocketRails[:newTimes].trigger 'update',  result
		#render "scheduler/main"

	end

	def postNewTimes
		# process data

		# Prepare data and broadcast it via Websocket!
		r = ((IDEALENDTIME - IDEALSTARTTIME) * 2).to_i
		c = IDEALDATES.length
		d = []
		r.times do |i|
			d << (1..c).map{rand(0..10)}
		end
		#d = (1..r*c).map{rand(0..10)}
		result = JSON.generate({rows: r, cols: c, data: d})
		WebsocketRails[:newTimes].trigger 'update',  result
	end

end
