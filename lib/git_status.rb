#!/usr/bin/env ruby

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
			"uptodate"
		else
			change_list = message.split("\n")										# create an array of the separate lines (ie each file)
			change_list.collect! { |change| change[0...2] }			# scan though the elements and keep only the first 2 characters
			counts      = Hash.new(0)
			for change in change_list
				counts[change] += 1
			end	
		  
		  "[#{counts['M ']}][#{counts[' M']}][#{counts['??']}]"
		  
		end	
	end
	
end

# invocation tests =========================
path = "/home/rob/scripts/Projects/rails_projects/sample_app"
path2 = "/home/rob/scripts/Projects/rails_projects/first_app"
git = GitStatus.new(path)
#~ puts git.inspect
#~ puts File.stat(git.path).ftype
#~ puts "#{git.path}/.git"
#~ puts git.message.class
puts git.summary
#~ puts git.message
