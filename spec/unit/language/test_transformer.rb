require 'spec_helper'
module Gisele::Language
  describe Transformer do

    let(:transformer_class){
      Class.new(Transformer) do

        def on_hello(node)
          [:seen_hello, node]
        end

        def on_copy(node)
          copy_and_applyall(node)
        end

        def on_missing(node)
          [:seen_missing, node]
        end

      end
    }
    let(:transformer){ transformer_class.new }

    describe 'call' do

      it 'dispatches to existing methods' do
        ast = [:hello, "world"]
        transformer.call(ast).should eq([:seen_hello, [:hello, "world"]])
      end

      it 'calls on_missing when not found' do
        ast = [:nosuchone, "world"]
        transformer.call(ast).should eq([:seen_missing, [:nosuchone, "world"]])
      end

      it 'raises an ArgumentError unless called on a non terminal' do
        lambda{
          transformer.call("world").should raise_error(ArgumentError, /world/)
        }
      end

    end

    describe "copy_and_applyall" do

      it 'provides a friendly way of applying copy/recurse' do
        ast = [:copy, [:hello, 'world'], "!"]
        transformer.call(ast).should eq([:copy, [:seen_hello, [:hello, "world"]], "!"])
      end

    end

  end
end