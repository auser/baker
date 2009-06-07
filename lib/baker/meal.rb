=begin rdoc
  The meal of the baker
=end
module Baker
  class Meal
    
    attr_reader :cookbook_directory
    
    def json(str, &block)
      
    end
    
    def template(*tplates)
      return templates if tplates.empty?
      tplates.each do |fpath|
        fpath = File.expand_path(fpath)
        if File.file?(fpath)
          templates << Template.new(:file => fpath, :cookbook_directory => cookbook_directory)
        elsif File.directory?(fpath)
          Dir["#{fpath}/**"].each {|f| template(f) }
        else
          $stderr.puts "The template #{fpath} does not exist"
        end
      end
    end
    
    def templates(*n)
      if n && !n.empty?
        template *n
      else
        @templates ||= []
      end      
    end
    
  end
end