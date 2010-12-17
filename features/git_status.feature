# the aim of this script is to take an arguement of a directory path, ensure it has a git repository
# run the 'git status' command and interrogate the response for a status message
# something like....

`git status -s` returns
M  README						# files that are staged => preceded by "M "
 M Rakefile					# known files that are "Changed but not updated" => preceded by " M"
?? New Empty File		# Untracked files => preceded by "??"
?? New Empty File2  # Untracked files => preceded by "??"

# output [1][1][2]

# this will be run by conky, such that 

#=========================
#     ::  Git:sample_app		uptodate
#     ::  Git:demo_app		  [1][1][2]



