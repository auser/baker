=begin rdoc
  The meal of the baker
=end
module Baker
  class Attributes < Base
    
    attr_reader :attributes, :basename
    
    def initialize(opts={})
      @attributes = {}
      @basename = opts.delete(:basename)
      super
    end
    
    def compile(template_name)
    end
    
    def variables(vars)
      case vars
      when Hash
        set_hash_attributes(vars)
      end
    end
    
    private
    
    def set_hash_attributes(hsh)
      @attributes.merge!(hsh)
    end
    
    def print_variable(var_name, var_hash)
      dir = "#{cookbook_directory}/#{attr_path}"
      ::FileUtils.mkdir_p dir unless ::File.directory?(dir)
      File.open("#{dir}/#{var_name}.rb", "w") do |f|
        f << "# variable #{basename}\n#{basename} Mash.new unless attribute?('#{basename}')\n\n"
        content = var_hash.map do |k,v|
          "#{basename}['#{var_name}']['#{k}'] = #{handle_print_variable(v)}"
        end.join("\n")
        f << content
      end
    end
    
    def attr_path
      "attributes"
    end
    
    def handle_print_variable(obj)
      case obj
      when Fixnum
        case obj
        when /^\d{3}$/
          "0#{obj.to_i}"
        else
          "#{obj.to_i}"
        end        
      when String
        case obj
        when /^\d{4}$/
          "#{obj}"
        when /^\d{3}$/
          "0#{obj}"
        else
          "\"#{obj}\""
        end
      when Proc
        obj.call # eh
      when Array
        # If we are sending a notifies with a second argument
        if obj[1] && [:immediately, :delayed].include?(obj[1])
          "#{handle_print_variable(obj[0])}, :#{obj[1]}"
        else
          "[ #{obj.map {|e| handle_print_variable(e) }.reject {|a| a.nil? || a.empty? }.join(", ")} ]"
        end        
      when nil
        nil
      when Symbol
        ":#{obj}"
      when Hash
        "#{obj.map {|k,v| ":#{k} => #{handle_print_variable(v)}" unless v == obj }.compact.join(",\n")}"
      else
        "#{obj}"
      end
    end
        
  end
end