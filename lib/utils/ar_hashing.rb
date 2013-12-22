module ActiveRecordHashing
  def to_hash
      Hash[*self.map{ |m| [m.id, m]}.flatten]               
  end
end