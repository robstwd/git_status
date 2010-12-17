require 'git_status'

describe GitStatus do

	before :each do
      @git_stat  = GitStatus.new("/home/rob/scripts/Projects/rails_projects/sample_app")
      @git_stat2  = GitStatus.new("/home/rob/scripts/Projects/rails_projects/first_app")
  end
	
	it "should be initialised with a valid directory" do
		File.directory?(@git_stat.path).should be_true
		File.stat(@git_stat.path).file?.should be_false
	end
	
	it "should reference a path that contains a git repository" do
		File.stat("#{@git_stat.path}/.git").directory?.should be_true
	end
	
	it "should output a string message from the system command `git status`" do
		@git_stat.message.class.should == String
	end
	
	it "should return 'uptodate' when there is nothing to commit (ie working directory clean)" do
		if @git_stat.message == "" then
			@git_stat.summary.should == "uptodate"
		end
	end
	
	it "should return '[n][n][n]' when there are any files to be committed" do
		if @git_stat.message != "" then
			@git_stat.summary.should match(/\[\d+\]\[\d+\]\[\d+\]/)      # ie [n][n][n] (where there may be any number of digitd)
		end
	end
	
end

