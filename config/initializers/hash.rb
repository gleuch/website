class Hash

  def sample(n=1)
    self.to_a.sample(n).to_h
  end

  def in_groups_of(*args)
    to_a.in_groups_of(*args).inject([]) do |accum, group|
      accum << group.inject({}) {|acc, pair| pair.nil? ? acc : acc.merge(pair.first => pair.last)}
    end
  end

end
