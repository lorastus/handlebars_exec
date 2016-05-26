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

end

