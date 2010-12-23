Feature: error message is outputted when an invalid arguement is passed

	As a beginning user of these technologies
	I want to see relevant feedback via error messages when I get it wrong
	So that I can make changes to get it right
	
	Scenario: the arguement provided is not a directory
		Given that the arguement provided is not a directory
		When I request the status with this script
		Then "not a directory" should be the output

	Scenario: the path provided in the arguement does not contain a git repo
		Given that the path provided in the arguement does not contain a git repo
		When I request the status with this script
		Then "no git repo" should be the output
