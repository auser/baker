require "#{File.dirname(__FILE__)}/../test_helper"

class MealTest < Test::Unit::TestCase
  context "template" do
    setup do
      @meal = Baker::Meal.new("#{File.dirname(__FILE__)}/../test_dir")
    end
    
    should "not add a template who's file doesn't exist" do
      swallow_output do
        @meal.template "/non/existant/path"
      end      
      assert_equal [], @meal.templates
    end
    
    should "add a template where the file does exist" do
      tfile = "#{File.dirname(__FILE__)}/../fixtures/template_fixture.erb"
      @meal.template tfile
      assert_equal File.expand_path(tfile), @meal.templates.first.file
    end
    
    should "add the files in the directory" do
      tfile = "#{File.dirname(__FILE__)}/../fixtures/template_dir"
      @meal.template tfile
      assert_equal File.expand_path("#{tfile}/dumb_template.erb"), @meal.templates[0].file
      assert_equal File.expand_path("#{tfile}/smart_template.erb"), @meal.templates[2].file
      assert_equal File.expand_path("#{tfile}/inner/girls_template.erb"), @meal.templates[1].file
    end
  end
  
end