require 'spec_helper'
describe Gisele do
  include Gisele

  describe "parse" do

    it 'works with a file' do
      parsed = parse(fixtures_dir/:tasks/"simple.gis")
      parsed.should be_a(Citrus::Match)
    end

    it 'works on a String' do
      parsed = parse("task Hello end")
      parsed.should be_a(Citrus::Match)
    end

    it 'accepts parse options' do
      parsed = parse("if goodCond Task1 end", :root => :if_st)
      parsed.should be_a(Citrus::Match)
    end

  end

  describe "ast" do

    it 'accepts parse options' do
      ast = ast(parse("if goodCond Task1 end", :root => :if_st))
      ast.should be_a(Sexpr)
      ast.first.should eq(:if_st)
    end

    it 'sets traceability marks correctly' do
      ast = ast(parse("if goodCond Task1 end", :root => :if_st))
      ast.tracking_markers[:citrus_match].should_not be_nil
    end

    fixture_files('tasks/**/*.gis').each do |file|
      it "works on #{file}" do
        parsed = ast(parse(file))
        parsed.should be_a(Array)
        parsed.should be_a(Sexpr)
        parsed.first.should eq(:unit_def)
        if (astfile = file.sub_ext(".ast")).exist?
          parsed.should eq(Kernel::eval(astfile.read, TOPLEVEL_BINDING, astfile.to_s))
        end
      end
    end

  end

end