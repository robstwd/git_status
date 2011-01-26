require 'git_status'

describe GitStatus do

	before :each do
    @git_sampleapp  = GitStatus.new("/home/rob/scripts/Projects/rails_projects/sample_app")
    @git_firstapp   = GitStatus.new("/home/rob/scripts/Projects/rails_projects/first_app")	# clean working dir & origin/master in sync
    @git_notapath   = GitStatus.new("/home/rob/scripts/Projects/rails_projects/first_app/README.markdown")
    @git_nogitrepo  = GitStatus.new("/home/rob/scripts/Projects/CDA_validator")
    @git_pathdoesntexist  = GitStatus.new("/home/rob/scripts/Projects/nothing")    
    @git_origin_outofdate  = GitStatus.new("/home/rob/scripts/Projects/git_status")    
  end
	
	it "should be initialised with a valid directory" do
		File.directory?(@git_sampleapp.path).should be_true
		File.stat(@git_sampleapp.path).file?.should be_false
	end
	
	it "should return 'not a directory' if the arguement is not a path" do
		@git_notapath.summary.should == "not a directory"
	end
	
	it "should reference a path that contains a git repository" do
		File.stat("#{@git_sampleapp.path}/.git").directory?.should be_true
	end
	
	it "should return 'no git repo' if the path doesn't contain a git repo" do 
		@git_nogitrepo.summary.should == "no git repo"
	end
	
	it "should return 'no such directory' if the path doesn't actually exist" do 
		@git_pathdoesntexist.summary.should == "no such directory"
	end
	
	it "should output a string message" do
		@git_sampleapp.summary.class.should == String
		@git_notapath.summary.class.should == String
		@git_nogitrepo.summary.class.should == String
	end
	
	it "should return 'uptodate' when there is nothing to commit (ie working directory clean)" do
		if @git_sampleapp.message == "" then
			@git_sampleapp.summary.should == "up to date"
		end
		if @git_firstapp.message == "" then
			@git_firstapp.summary.should == "up to date"
		end
		
	end
	
	it "should return '[n]  [n]  [n]' when there are any files to be committed" do
		if @git_sampleapp.message != "" then
			@git_sampleapp.summary.should match(/\[\d+\]  \[\d+\]  \[\d+\]/)     # ie [n]  [n]  [n] (where there may be any number of digits)
		end
		if @git_firstapp.message != "" then
			@git_firstapp.summary.should match(/\[\d+\]  \[\d+\]  \[\d+\]/)      # ie [n]  [n]  [n] (where there may be any number of digits)
		end		
		
	end
	
	context "origin status" do
		it "should return 'origin up-to-date' when the origin is up to date with the local repo" do
			@git_firstapp.origin_status.should == "up-to-date"
		end
		it "should return 'origin out-of-date' when the origin is not up to date with the local repo" do
			@git_origin_outofdate.origin_status.should == "out-of-date"
		end
		
	end
	
end
