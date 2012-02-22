module Gisele
  module Language
    module AST
      module Node

        def citrus_match
          tracking_markers[:citrus_match]
        end

        # Returns a label for this AST node
        def label
          ""
        end

        # Returns attributes to use for dot printing
        def dot_attributes
          attrs = Language::DOT_ATTRIBUTES[first.to_s] || {}
          attrs.merge(:label => label)
        end

        # Checks validity over the definition
        def ===(sexp)
          Language[rule_name] === sexp
        end

      end # module Node
    end # module AST
  end # module Language
end # module Gisele
require_relative 'unit_def'
require_relative 'task_call_st'
require_relative 'while_st'
require_relative 'if_st'
require_relative 'else_clause'
require_relative 'elsif_clause'
require_relative 'case_st'
require_relative 'when_clause'
require_relative 'bool_expr'
require_relative 'bool_and'
require_relative 'bool_or'
require_relative 'bool_not'
require_relative 'var_ref'
require_relative 'par_st'
require_relative 'task_def'