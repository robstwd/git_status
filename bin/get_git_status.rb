#!/usr/bin/env ruby 
       
#       Copyright 2010 Rob Eastwood <rob.eastwood8@gmail.com>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

#  
#  name: 			get_git_status.rb
#  purpose:		this is the main program for this package 
#							refer to readme.md for usage details

require_relative '../lib/git_status'

path = ARGV[0]

git = GitStatus.new(path)
puts git.summary
