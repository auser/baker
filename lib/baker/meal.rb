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
        
    def template(*temps)
      temps.each do |temp|
        tfile = File.expand_path(temp)
        if File.file?(tfile)
          templates << Baker::Template.new(:file => tfile, :cookbook_directory => cookbook_directory) unless template_files.include?(tfile)
        elsif File.directory?(tfile)
          Dir["#{tfile}/**/*"].each do |t|
            template(File.expand_path(t))
          end
        else
          raise StandardError.new("Meal template accepts only files or directories. Please check your call to template")
        end
      end
    end
    
    def template_files
      templates.map {|a| a.file }
    end
    
    def templates
      @templates ||= []
    end
        
  end
end