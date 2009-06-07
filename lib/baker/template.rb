module Baker
  class Template < Base
    
    attr_accessor :file
    
    def initialize(opts)
      @options = extract_options(opts)
      @file = File.expand_path( options[:key] ? options[:key] : options[:file])
      raise StandardError.new("Given template #{file} does not exist") unless File.file?(file)
      super
    end
    
    def content
      @content ||= open(file).read # Not sold on this yet
    end
    
    def compile(template_name)
      dir = "#{cookbook_directory}/templates/default"
      ::FileUtils.mkdir_p dir unless ::File.directory?(dir)
      File.open("#{dir}/#{template_name}", "w") {|f| f << content}
    end
    
  end
end