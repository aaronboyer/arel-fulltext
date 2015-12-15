module Arel
  module Visitors
    class MySQL < Arel::Visitors::ToSql
      private
      def visit_Arel_Nodes_FullTextMatch o, collector
        collector << 'MATCH('
        collector = visit o.left, collector
        collector << ') AGAINST('
        collector << quote(o.right)

        opts = ' IN BOOLEAN MODE'
        unless o.opts.nil?
          if o.opts[:native_mode]
            opts = ''
          elsif o.opts[:query_expansion]
            opts = ' WITH QUERY EXPANSION'
          end
        end

        collector << opts
        collector << ')'

        collector
      end
    end
  end
end
