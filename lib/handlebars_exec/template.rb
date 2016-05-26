module HandlebarsExec
  class Template
    def initialize context, template
      @context = context
      @template_string= template
    end

    def template variables
      @context.eval("Handlebars.compile('#{@template_string}')(#{variables.to_json})")
    end
  end
end
