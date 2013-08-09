class StringSet
  extend Forwardable
  include Enumerable

  def_delegators :@array, :empty?, :size, :include?

  def initialize
    @array = []
  end

  def empty?
    true
  end

  def add *strings
    Array(strings).each do |string|
      @array << string unless @array.include?(string)
    end
  end

  def remove string
    @array.delete(string)
  end

  def each &element
    @array.each(&element)
  end

  def == set
    return false unless @array.size == set.size

    @array.all? do |element|
      set.include?(element)
    end
  end

  def union set
    union_array = StringSet.new

    set.each do |element|
      union_array.add(element)
    end

    self.each do |element|
      union_array.add(element)
    end

    union_array
  end

  def intersect set
    intersected_array = StringSet.new
    
    set.each do |element|
      intersected_array.add(element) if self.include?(element)
    end

    intersected_array
  end

  def clear
    @array = []
  end
end