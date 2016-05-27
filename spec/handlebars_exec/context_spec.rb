require 'spec_helper'

describe HandlebarsExec::Context do

  let(:subject) { HandlebarsExec::Context.new }

  describe "a simple template" do

    describe "compiled" do
      let(:compiled_template) { subject.compile("Hello {{name}}") }
      it "compiles a template" do
        compiled_template.must_be_instance_of HandlebarsExec::Template
      end
    end
  end

  describe "#register_helper_file" do
    let(:helper_file_path) { 'spec/fixtures/phone_helpers.js' }
    before(:context) do
      subject.register_helper_file(helper_file_path)
    end
    it "has a helper" do
      subject.context.eval('typeof Handlebars.helpers["formatPhoneNumber"]').must_equal "function"
    end
  end

  describe "#register_helper" do
    let(:helper) { File.read 'spec/fixtures/phone_helpers.js' }
    before(:context) do
      subject.register_helper(helper)
    end
    it "has a helper" do
      subject.context.eval('typeof Handlebars.helpers["formatPhoneNumber"]').must_equal "function"
    end
  end

  describe "#register_partial_file" do
    let(:partial_file_path) { 'spec/fixtures/partial.hbs' }
    before(:context) do
      subject.register_partial_file(partial_file_path)
    end
    it "has a partial" do
      subject.context.eval('typeof Handlebars.partials["myPartial"]').must_equal "string"
    end
  end

  describe "#register_partial" do
    let(:partial) { File.read 'spec/fixtures/partial.hbs' }
    before(:context) do
      subject.register_partial(partial)
    end
    it "has a partial" do
      subject.context.eval('typeof Handlebars.partials["myPartial"]').must_equal "string"
    end
  end
end

