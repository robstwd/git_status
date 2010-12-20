require 'git_status'

describe GitStatus do

	before :each do
    @git_sampleapp  = GitStatus.new("/home/rob/scripts/Projects/rails_projects/sample_app")
    @git_firstapp   = GitStatus.new("/home/rob/scripts/Projects/rails_projects/first_app")
    @git_notapath   = GitStatus.new("/home/rob/scripts/Projects/rails_projects/first_app/README.markdown")
    @git_nogitrepo  = GitStatus.new("/home/rob/scripts/Projects/CDA_validator")
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
	
end

