

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


