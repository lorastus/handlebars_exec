require "execjs"
require "handlebars/source"

module HandlebarsExec
  class Context

    attr_reader :context
    def initialize
      @sources= []
      @_handlebars_source = File.read Handlebars::Source.bundled_path
      @context = generate_context
    end

    def generate_context
      sources = ([@_handlebars_source] + @sources).join("\n")
      ExecJS.compile(sources)
    end

    def compile template
      HandlebarsExec::Template.new self.context,template 
    end

    def add_file_to_context file
      add_to_context File.read(file)
    end
    alias :register_helper_file :add_file_to_context
    alias :register_partial_file :add_file_to_context

    def add_to_context str
      @sources.push (str)
      if context_preserved_between_calls?
        context.eval("(function(){ #{str}})()")
      else
        # ExecJS::ExternalRuntime::Context does not have a writable context
        # the only way to attach new variables and functions is to destroy the old context
        @context = generate_context
      end
    end
    alias :register_helper :add_to_context
    alias :register_partial :add_to_context

    private
      def context_preserved_between_calls?
        [
          "ExecJS::RubyRacerRuntime::Context",
          "ExecJS::MiniRacerRuntime::Context"
        ].include? context.class.to_s
      end
  end
end
