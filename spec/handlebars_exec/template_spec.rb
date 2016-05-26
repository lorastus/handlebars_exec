require "spec_helper"

describe HandlebarsExec::Template do
  let(:context) { HandlebarsExec::Context.new }
  let(:subject) { HandlebarsExec::Template.new context.context, template_string }

  describe "a simple template" do
    let(:template_string) { "Hello {{name}}" }

    it "allows simple subsitution" do
      subject.template(name: "World").must_equal "Hello World"
    end
  end

  describe "a template with hash attributes" do
    let(:template_string) { "Hello {{name.last}}" }

    it "allows simple subsitution" do
      subject.template(name: { last: "World"}).must_equal "Hello World"
    end
  end

  describe "a template with an array " do
    let(:template_string) { "Hello {{#each name}}{{this}}{{/each}}" }

    it "allows simple subsitution" do
      subject.template(name: %w(W o r l d)).must_equal "Hello World"
    end
  end

end
