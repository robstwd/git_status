class GitStatus
	attr_reader :path
	
	def initialize(path)
		@path = path
	end
	
	def message
		if File.exist?(@path) == false then
			"no such directory"
		elsif File.stat(@path).directory? == false then
			"not a directory"
		elsif File.exist?("#{@path}/.git") == false then
			"no git repo"
		else
			@result = `cd #{path} && git status -s`
		end

	end
	
	def summary
		if message == "not a directory" then
			"not a directory"
		elsif message == "no git repo" then
			"no git repo"
		elsif message == "no such directory" then
			"no such directory"
		elsif message == "" then
			"up to date"
		else
			change_list = message.split("\n")										# create an array of the separate lines (ie each file) => ["AM README.md", " M bin/get_git_status.rb"]
			change_list.collect! { |change| change[0...2] }			# scan though the elements and keep only the first 2 characters => ["AM", " M"]
			counts      = Hash.new(0)														# create a hash object to collect the counts
		  
		  change_list.each do | change |											# iterate over all of the git status records
	
				if change[0...2] == "??" then											# when the status is "??" then 
					counts[:untracked] += 1				      						# increment the count of :untracked by 1
				else 																							# when the status is NOT "??" then 
					if change[0] != " " then											  # when the status has a value in the first character then
						counts[:staged] += 1			      				  		# increment the count of :staged by 1
					end	
					if change[1] != " " then											  # when the status has a value in the second character then
						counts[:unstaged] += 1			      				  	# increment the count of :unstaged by 1
					end
				end
			end

		  staged    = counts[:staged]
		  unstaged  = counts[:unstaged]
		  untracked = counts[:untracked]

		  "[#{staged}]  [#{unstaged}]  [#{untracked}]"				# return the result in format => [n]  [n]  [n]
		
		end	
		
	end
	
	# determine whether the remote origin/master has been updated from the last local commit
	def origin_status
		
		# the git alias of `git hist` outputs each commit on a single line with the comment & status; such as
				#~ * f5223de 2010-12-12 | added Heroku link to the readme (HEAD, origin/master, master) [Rob Eastwood]
				#~ * 147a325 2010-12-12 | Improved the README (heroku/master) [Rob Eastwood
		@result = `cd #{@path} && git hist`
		
		# when the last commit has been pushed to the remote origin/master, then the log will include the text "origin/master, master", as above
		if @result.include? "origin/master, master" then
			"up-to-date"
		else
			"out-of-date"
		end
	end
	
end 


