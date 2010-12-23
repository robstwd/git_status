Given /^that a git repo exists for a given project$/ do
  @git_sampleapp  = GitStatus.new("/home/rob/scripts/Projects/rails_projects/sample_app")
  File.stat("#{@git_sampleapp.path}/.git").directory?.should be_true
end

When /^I request the status with this script$/ do
  @git_sampleapp.summary
end

Then /^I should see "([^"]*)"$/ do |status|
  @git_sampleapp.summary.should include(status)
end
