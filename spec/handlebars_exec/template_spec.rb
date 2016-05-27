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

  describe "with a helper" do
    let(:helper) { 'spec/fixtures/phone_helpers.js' }
    let(:template_string) { "call {{formatPhoneNumber telephone}}" }
    before(:context) do
      context.register_helper_file(helper)
    end
    it "can use a helper" do
      subject.template(telephone: "2813308004").must_equal "call (281) 330-8004"
    end
  end

  describe "with a partial" do
    let(:partial) { 'spec/fixtures/partial.hbs' }
    let(:template_string) { "Hello {{> myPartial}}" }
    before(:context) do
      context.register_partial_file(partial)
    end
    it "can use a partial" do
      subject.template(name: "World").must_equal "Hello World"
    end
  end
end
