# the aim of this script is to take an arguement of a directory path, ensure it has a git repository
# run the 'git status' command and interrogate the response for a status message
# something like....
# if all changes have been committed with the result of:
		# On branch master
		# nothing to commit (working directory clean)
		# => then output "uptodate"
# otherwise if there are uncommitted changes, like
		# On branch master
		# Changes to be committed:
		#   (use "git reset HEAD <file>..." to unstage)
		#
		#       new file:   newfile
		#
		# Changed but not updated:
		#   (use "git add <file>..." to update what will be committed)
		#   (use "git checkout -- <file>..." to discard changes in working directory)
		#
		#       modified:   README
		#
		# Untracked files:
		#   (use "git add <file>..." to include in what will be committed)
		#
		#       New Empty File1
		#       New Empty File2

# output [1][1][2]

# this will be run by conky, such that 

#=========================
#     ::  Git:sample_app		uptodate
#     ::  Git:demo_app		  [1][1][2]
