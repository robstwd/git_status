class GitStatus
	attr_reader :path
	
	def initialize(path)
		@path = path
	end
	
	def message
		@result = `cd #{path} && git status -s`
	end
	
	def summary
		if message == "" then
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
	
end 




