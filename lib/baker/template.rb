module Baker
  class Template < Base
    
    attr_accessor :file
    
    def initialize(opts={})
      @options = extract_options(opts)
      @file = File.expand_path( options[:key] ? options[:key] : options[:file])
      raise StandardError.new("Given template #{file} does not exist") unless File.file?(file)
      super
    end
    
    def all
      Dir["#{full_path}/*"].map {|template| File.basename(template)}
    end
    
    def content
      @content ||= open(file).read # Not sold on this yet
    end
    
    def template_path
      "templates/default"
    end
    
    def full_path
      "#{cookbook_directory}/#{template_path}"
    end
    
    def compile(template_name)      
      ::FileUtils.mkdir_p full_path unless ::File.directory?(full_path)
      File.open("#{full_path}/#{template_name}.erb", "w") {|f| f << content}
    end
    
  end
end