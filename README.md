# git_status
		
This script scans a supplied path for a git repository and outputs a summarised status for [Conky](http://conky.sourceforge.net/).

Just my efforts to learn some more Ruby, RSpec, Git and Conky.

## Output

Depending upon the status it will output 2 main options:

1. if the git repo is clean ie no changes found, output is => `up to date`
2. if the repo has some changes needing attention, the output changes to => `[n1]  [n2]  [n3]`
    * where n1 = the number staged changes to tracked files, ready for committing
    * where n2 = the number of tracked files that have been modified but not yet staged
    * where n3 = the number of untracked files
3. If a arguement is passed that is not a directory, output is `not a directory`
4. If a arguement is passed that is a directory, but doesn't contain a git repository, output is `no git repo`

## Output process
For a project that has a Git repository and is tracked with this script, the changes that will be seen (as updated every 10 seconds as is configured below)is as follows:
1. Before making any changes to any project files,  output is => `up to date` (in green)
2. When a new file is added (assuming that it does not meet .gitignore criteria),   output becomes => `[0]  [0]  [1]`
3. When a file that is tracked by git is modified,  output becomes => `[0]  [1]  [1]`
4. When the new file is added to the staging area (without any modifications), output becomes => `[1]  [1]  [0]`
5. When "git commit -m 'file x added'" is run, output becomes => `[0]  [1]  [0]`
6. When the modified file is added to the stageing area, output becomes => `[1]  [0]  [0]`
7. Lastly, when "git commit -m 'changed file z'" is run, output becomes =>`up to date`

## Conky Config
Conky config file to contain something like the following:

`${execpi 10 ruby /path/to/script-root-folder/bin/get_git_status.rb /path/to/project-dir-that-holds-the-git-repo}`

* `execpi` => runs the script
* `10` 		 => every 10 seconds
* `ruby`   => runs the ruby executable
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

* checks first that the arguament passed is a directory which contains a git repository (ie a subfolder in the project root directory of `.git`)

* looks for (and counts) records that have a value in the first position (ie signifying that there is a staged change to tracked files, ready for committing.

* looks for (and counts) records that have a value in the second position (ie signifying that a tracked file has been modified but not yet staged.

* looks for (and counts) records with "??" that signifies that files have not been tracked.

## Dependencies

* Ruby v1.9.x ('require_relative' in the main file only works with Ruby v1.9.x)
* Git (works with v1.7.3.4; previous versions untested)
* Conky (works with v1.8.1; previous versions untested)

## TODO
1. do a better validation that a git repository has been initialised, rather than just checking that a sub-directory `.git` exists.
(=> try running `git status` and check that `fatal: Not a git repository` is not returned)
