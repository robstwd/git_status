#!/usr/bin/env ruby 
path        = "~/scripts/Projects/git_status"
path        = "/home/rob/scripts/Projects/rails_projects/first_app/README.markdown"
result      = `cd #{path} && git status -s`
puts $?
puts $?.exitstatus
change_list = result.split("\n").collect! { |change| change[0...2] }
puts change_list.inspect
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

puts counts

staged    = counts[:staged]
unstaged  = counts[:unstaged]
untracked = counts[:untracked]

puts "[#{staged}]-[#{unstaged}]-[#{untracked}]"

