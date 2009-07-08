=begin rdoc
  The meal of the baker
=end
module Baker
  class Meal
    
    attr_reader :cookbook_directory
    
    def initialize(cookbook_directory, opts={})
      raise StandardError.new("You must pass a directory to make the meal") unless cookbook_directory && cookbook_directory.is_a?(String)
      @cookbook_directory = cookbook_directory
    end
    
    def json(str, &block)
    end
        
    def template(*templates)
      templates.each do |temp|
        templates << Baker::Template.new(:file => temp, :cookbook_directory => cookbook_directory)
      end
    end
    
    def templates
      @templates ||= []
    end
        
  end
end