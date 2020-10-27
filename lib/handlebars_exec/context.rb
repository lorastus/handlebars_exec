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

    def compile template, options = {}
      HandlebarsExec::Template.new self.context, template, options
    end

    def precompile template, options = {}
      HandlebarsExec::Template.new self.context, template, options
    end

    def add_file_to_context file
      add_to_context File.read(file)
    end
    alias :register_helper_file :add_file_to_context
    alias :register_partial_file :add_file_to_context

    def register_partial_file name, file
      add_to_context "Handlebars.registerPartial('#{name}', #{File.read(file).strip.inspect});"
    end

    def register_helper name, function
      add_to_context "Handlebars.registerHelper('#{name}', #{function});"
    end
    def register_partial name, partial
      add_to_context "Handlebars.registerPartial('#{name}', #{partial.inspect});"
    end

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

    private
      def context_preserved_between_calls?
        [
          "ExecJS::RubyRacerRuntime::Context",
          "ExecJS::MiniRacerRuntime::Context"
        ].include? context.class.to_s
      end
  end
end
