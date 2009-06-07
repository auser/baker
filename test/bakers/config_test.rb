require "#{File.dirname(__FILE__)}/../test_helper"

class ConfigTest < Test::Unit::TestCase
  context "config" do
    should "accept a file and that file will be placed in the file var" do
      c = Baker::Config.new("#{File.dirname(__FILE__)}/../fixtures/config_fixture.erb")
      assert_equal open("#{File.dirname(__FILE__)}/../fixtures/config_fixture.erb").read, c.content
    end
    should "accept a string that will turn into the content" do
      c = Baker::Config.new("config for chef")
      assert_equal "config for chef", c.content
    end
    should "use the default config if nothing is passed" do
      c = Baker::Config.new
      assert_equal "cookbook_path     \"/etc/chef/cookbooks\"\nnode_path         \"/etc/chef/nodes\"\nlog_level         :info\nfile_store_path  \"/etc/chef\"\nfile_cache_path  \"/etc/chef\"\n", c.content
    end
  end
  
end
