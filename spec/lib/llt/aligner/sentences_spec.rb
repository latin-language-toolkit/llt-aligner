require 'spec_helper'

describe LLT::Aligner::Sentences do
  let(:aligner) { LLT::Aligner::Sentences.new() }

  def new_container(id)
    LLT::Core::Structures::HashContainable::Generic.new(id)
  end

  def new_containers(*ids)
    ids.map { |id| new_container(id) }
  end

  def custom_container(id)
    Class.new do
      include LLT::Core::Structures::HashContainable

      def to_s
        @id
      end
    end.new(id)
  end

  def custom_containers(*ids)
    ids.map { |id| custom_container(id) }
  end


  describe "#align_ids" do
    it "returns a dictionary of ids, identifying where id 1 of A is to be found in B" do
      a, b, = new_containers('a', 'b')
      s1, s2, = new_containers(1, 2)
      s3, s4 = new_containers(3, 4)

      a.add(s1)
      a.add(s2)
      b.add(s3)
      b.add(s4)

      w1, w2, w3, w4 = custom_containers('m', 'n', 'o', 'p')

      [w1, w2].each { |w| s1.add(w); s3.add(w) }
      [w3, w4].each { |w| s2.add(w); s4.add(w) }

      result = { 1 => 3, 2 => 4 }

      aligner.align_ids(a, b).should == result
    end
  end
end
