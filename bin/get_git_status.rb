#!/usr/bin/env ruby 

# example usage
# ruby ~/scripts/Projects/git_status/bin/get_git_status.rb /home/rob/scripts/Projects/rails_projects/sample_app

require_relative '../lib/git_status'

path = ARGV[0]

git = GitStatus.new(path)
puts git.summary
