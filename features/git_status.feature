Feature: status of git repository is outputted

	As a maintainer of a git repository
	I want to readily see the status of that repository
	So that I can keep up-to-date with maintaining it
	
	Scenario: no changes to git repo
		Given that a git repo exists for a given project
		When I request the status with this script
		Then I should see "up to date"

	Scenario: git repo has 1 staged change ready for commit
		Given that one one modification has been staged 
		When I request the status with this script
		Then I should see "[1]  [0]  [0]"

	Scenario: script is passed an arguement that is not a valid path
		Given that the argument passed is not a valid directory
		When I request the status with this script
		Then I should see "not a directory"
	
	Scenario: script is passed a path, but there is no git repo
		Given that the directory does not have a git repository
		When I request the status with this script
		Then I should see "no git repo"
