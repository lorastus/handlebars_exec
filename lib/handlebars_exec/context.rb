require "execjs"
require "handlebars/source"

module HandlebarsExec
  class Context

    attr_reader :context
    def initialize
      @context = ExecJS.compile(File.read Handlebars::Source.bundled_path)
    end

    def compile template
      HandlebarsExec::Template.new self.context,template 
    end
  end
end
