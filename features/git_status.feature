Feature: status of an initialised git repository is outputted

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
