require "#{File.dirname(__FILE__)}/../test_helper"

class RecipeTest < Test::Unit::TestCase
  should "raise if the file passed is not a file" do
    assert_raise StandardError do
      Baker::Recipe.new("not a file")
    end
  end
  should "open the recipe content when called with an existing recipe file" do
    assert_equal "package \"dummy_package\" do\n  action :install\nend", Baker::Recipe.new("#{File.dirname(__FILE__)}/../fixtures/recipe_fixture.erb").content
  end
  should "have a cookbook_directory" do
    recipe = Baker::Recipe.new( :file => "#{File.dirname(__FILE__)}/../fixtures/recipe_fixture.erb", 
                                    :cookbook_directory => "#{File.dirname(__FILE__)}/../test_dir")
    assert_equal "#{File.dirname(__FILE__)}/../test_dir", recipe.cookbook_directory
  end
  context "compiling" do
    setup do
      @cookbook_directory = "#{File.dirname(__FILE__)}/../test_dir"
      @recipe_file = "#{File.dirname(__FILE__)}/../fixtures/recipe_fixture.erb"
      @recipe = Baker::Recipe.new( :file => @recipe_file, :cookbook_directory => @cookbook_directory)
      FileUtils.rm_rf @cookbook_directory if File.directory?(@cookbook_directory)
    end
    
    teardown do
      # FileUtils.rm_rf @cookbook_directory if File.directory?(@cookbook_directory)
    end

    should "create the recipe directory (since it doesn't exist)" do
      assert !File.directory?("#{@cookbook_directory}/recipes")
      @recipe.compile("default")
      assert File.directory?("#{@cookbook_directory}/recipes")
    end
    should "store the content in the new file" do
      @recipe.compile("burbary")
      assert_equal "package \"dummy_package\" do\n  action :install\nend", open("#{@cookbook_directory}/recipes/burbary").read
    end
  end
  
end
