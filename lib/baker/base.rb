module Baker
  class Base
    attr_accessor :meal, :key
    attr_writer   :options, :cookbook_directory
    
    def initialize(opts={})
      @options = extract_options(opts)
      options.each {|k,v| self.send("#{k}=",v) } if options
    end
    
    def compile
      raise StandardError.new("This baker doesn't implement compile. Something is wrong")
    end
    
    def cookbook_directory
      @cookbook_directory ||= "#{meal ? meal.cookbook_directory : "./"}"
    end
    
    def options
      @options ||= {}
    end
    
    def extract_options(o={})
      if o.is_a?(String)
        {:key => o}
      else
        o
      end
    end
    
  end
end