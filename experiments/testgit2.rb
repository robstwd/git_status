#!/usr/bin/env ruby 

require_relative '../lib/git_status'

path1   = "/home/rob/scripts/Projects/rails_projects/first_app"
path2   = "/home/rob/scripts/Projects/rails_projects/first_app/README.markdown"
path3   = "/home/rob/scripts/Projects/CDA_validator"

git1 = GitStatus.new(path1)
puts git1.summary

git2 = GitStatus.new(path2)
puts git2.summary

git3 = GitStatus.new(path3)
puts git3.summary
