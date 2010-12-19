# git_status
		
This script scans a supplied path for a git repository and outputs a summarised status for [Conky](http://conky.sourceforge.net/).

Just my efforts to learn some more Ruby, RSpec, Git and Conky.

## Output

Depending upon the status it will output 2 options:

1. if the git repo is clean ie no changes found, output is => `up to date`
2. if the repo has some changes needing attention, the output changes to => `[n1]  [n2]  [n3]`
    * where n1 = the number staged changes to tracked files, ready for committing
    * where n2 = the number of tracked files that have been modified but not yet staged
    * where n3 = the number of untracked files

## Usage
Conky config file to contain something like the following:

`${execpi 10 ruby ~/path/to/the/script/root/folder/bin/get_git_status.rb /path/to/project/dir/that/holds/the/git/repo}`

* execpi => runs the script
* 10 		 => every 10 seconds
* ruby   => runs the ruby executable
* followed by the script path & name
* followed by the path to the project with the git repository

In my case it looks like this:

`${execpi 10 ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}`

I precede it with the name of the particular project, viz

`git_status $alignr${execpi 10 ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}`

And introduced colour variations so that 

* "up to date" is displayed in green
* any variation of [n]  [n]  [n] will display in red
 
      ${if_match "${exec ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}" == "up to date"}${color2}${execpi 10 ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}${color}${else}${color red}${execpi 10 ruby ~/scripts/Projects/git_status/bin/get_git_status.rb ~/scripts/Projects/git_status}${color}${endif}

With the colours predefined earlier in the conky file as:
 
    color1 00ffff
    color2 00ff00
    color3 ffff00
    color4 ff0000
 
## Under the bonnet

The script runs the shell command `git status -s` within the chosen directory.

The output is `XY filename` where (according to the git status man page):

* `XY` is the status (where X shows the status of the index, and Y shows the status of the work tree. And untracked paths, XY is displayed as `??`
* status codes are:
    * ' ' = unmodified
    * M = modified
    * A = added
    * D = deleted
    * R = renamed
    * C = copied
    * U = updated but unmerged
* `filename` refers to the particular file in question 

The code:

* looks for (and counts) records that have a value in the first position (ie signifying that there is a staged change to tracked files, ready for committing.

* looks for (and counts) records that have a value in the second position (ie signifying that a tracked file has been modified but not yet staged.

* looks for (and counts) records with "??" that signifies that files have not been tracked.

## TODO
1. error handling for an argument that isn't a path or the path doesn't contain a git repo
2. rspec these error handing options
3. document 
