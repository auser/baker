$:.unshift("#{File.dirname(__FILE__)}/baker")
require "rubygems"
require "json"

%w(base jsoner template recipe config include_cookbook attributes files meal).each do |lib|
  require "#{lib}"
end

module Baker
  def self.compile(dir, &block)
    m = Meal.new
    m.instance_eval &block if block
    m.compile
  end
end