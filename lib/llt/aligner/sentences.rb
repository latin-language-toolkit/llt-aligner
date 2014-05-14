# Aligns sentences in two strucurally similar documents,
# that only have rivalring id numbers.

module LLT
  module Aligner
    class Sentences
      # Compares the string values of two containers and returns
      # a hash of ids { id_in_a => id_in_b }
      #
      # Takes the string values of these containers and places them in
      # a new dictionary.
      # We iterate over these then and delete keys from the the b dict in case
      # we find an equivalent. This should reduce the computation time of this
      # method, as the length of the dictionary where we search things in is getting
      # shorter after every successful alignment.
      def align_ids(a, b)
        x, y = [a, b].map { |c| container_to_s(c) }
        x.each_with_object({}) do |(k, v), result|
          if equivalent = y.find { |_, other_v| v == other_v }
            other_key = equivalent.first
            result[k] = other_key
            y.delete(other_key)
          end
        end
      end

      private

      def container_to_s(container)
        container.each_with_object({}) { |(k, v), hsh| hsh[k] = v.to_s }
      end
    end
  end
end
