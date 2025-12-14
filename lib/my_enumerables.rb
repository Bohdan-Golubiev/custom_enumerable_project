# frozen_string_literal: true

module Enumerable
  def my_all?
    my_each { |e| return false unless (block_given? ? yield(e) : e) }
    true
  end

  def my_any?
    my_each { |e| return true if block_given? ? yield(e) : e }
    false
  end

  def my_count
    total = 0
    my_each { |e| total += 1 if block_given? ? yield(e) : true }
    total
  end

  def my_each
    ary = to_a
    i = 0
    while i < ary.size
      yield ary[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    idx = 0
    my_each do |e|
      yield(e, idx)
      idx += 1
    end
    self
  end

  def my_inject(initial = nil)
    accumulator = initial
    my_each do |e|
      accumulator = accumulator.nil? ? e : yield(accumulator, e)
    end
    accumulator
  end

  def my_map
    result = []
    my_each { |e| result << yield(e) }
    result
  end

  def my_none?
    my_each { |e| return false if yield(e) }
    true
  end

  def my_select
    result = []
    my_each { |e| result << e if yield(e) }
    result
  end
end

# Примеры использования
if __FILE__ == $PROGRAM_NAME
  test_array = (1..20).to_a
  puts "Array: #{test_array}"
  puts "All < 21? #{test_array.my_all? { |num| num < 21 }}"
  puts "Any > 15? #{test_array.my_any? { |num| num > 15 }}"
  puts "Sum: #{test_array.my_inject { |sum, n| sum + n }}"
end