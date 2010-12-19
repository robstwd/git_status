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
			counts      = Hash.new(0)
		  
		  change_list.each do | change |
	
				if change[0...2] == "??" then
					counts[:untracked] += 1
				else 
					if change[0] != " " then
						counts[:staged] += 1
					end	
					if change[1] != " " then
						counts[:unstaged] += 1
					end
				end
			end

		staged    = counts[:staged]
		unstaged  = counts[:unstaged]
		untracked = counts[:untracked]

		"[#{staged}]  [#{unstaged}]  [#{untracked}]"
		
		end	
	end
	
end 




