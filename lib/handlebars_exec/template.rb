module HandlebarsExec
  class Template
    def initialize context, template, options
      @context = context
      @template_string = template
      @options = options
    end

    def template variables
      @context.eval("Handlebars.compile(#{@template_string.inspect}, #{@options.to_json})(#{variables.to_json})")
    end
  end
end
