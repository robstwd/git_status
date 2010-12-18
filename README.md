#  Purpose:		
This script scans a supplied path for a git repository and outputs a summarised status for conky

# Output
depending upon the status it will output 2 options:
1) if the git repo is clean ie no changes found, output is => uptodate
2) if the repo has some changes needing attention, the output changes to => [n1][n2][n3]
		where n1 = the number staged changes, ready for committing
		where n2 = the number of tracked files that have been modified but not yet staged
		where n3 = the number of untracked files

# Usage
Conky file to contain the following
${execpi 10 ruby ~/path/to/the/script/root/folder/bin/get_git_status.rb /path/to/project/dir/that/holds/the/git/repo}

In my case it looks like this:
${execpi 10 ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}	

# Under the bonnet
The script runs the shell command "git status -s" within the chosen directory
the output is "XY <filename>" where (according to the git status man page):
	- <XY> is the status (where X shows the status of the index, and Y shows the status of the work tree. And untracked paths, XY is displayed as ??
			status codes are:
       ·   ' ' = unmodified
       ·    M = modified
       ·    A = added
       ·    D = deleted
       ·    R = renamed
       ·    C = copied
       ·    U = updated but unmerged
	- <filename> refers to the particular file in question 

# TODO
1) error handling for an argument that isn't a path or the path doesn't contain a git repo
2) rspec these error handing options
3) fix the count when a new file is added to the stage (ie git status -s => "A  README.md") and probably a bunch of other options
4) push to GitHub
