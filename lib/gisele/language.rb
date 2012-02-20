module Gisele
  module Language

    require 'yaml'
    DOT_ATTRIBUTES = YAML.load_file(Path.dir/"language/grammar.dot.yml")
    SEXP_GRAMMAR   = SexpGrammar.load Path.dir/"language/grammar.sexp.yml"

    RESERVED_WORDS = [
      "if",
      "else",
      "elsif",
      "when",
      "while",
      "seq",
      "par",
      "task",
      "refinement",
      "fluent",
      "trackvar",
      "initially",
      "end",
      "not",
      "or",
      "and",
      "true",
      "false"
    ]

    def rule2mod(rule)
      rule.to_s.gsub(/(^|_)([a-z])/){|x| $2.capitalize}.to_sym
    end
    module_function :rule2mod

    def mod2rule(mod)
      mod = mod.name.to_s.split('::').last.to_sym if mod.is_a?(Module)
      mod.to_s.gsub(/[A-Z]/){|x| "_#{x.downcase}"}[1..-1].to_sym
    end
    module_function :mod2rule

  end # module Language
end # module Gisele
require_relative 'language/syntax'
require_relative 'language/ast'
require_relative 'language/rewriter'
require_relative 'language/processors'
