require_relative "solution_helper"
include SolutionHelper

def array_increases_only(arr)
  arr.each_cons(2).to_a.all? { |a, b| a < b }
end

def viable_password?(password)
  pairs = password.to_s.split('').each_cons(2).to_a

  pairs.all? { |a, b| a <= b } && pairs.any? { |a, b| a == b }
end

def one_standalone_pair?(password)
  chunks = password.to_s.split('').chunk { |char| char }.to_a

  chunks.any? { |char, chunk| chunk.count == 2 }
end

def solve_a(data = "246540-787419")
  lower, upper = data.split('-').map(&:to_i)

  (lower..upper).select { |i| viable_password?(i) }.count
end

def solve_b(data = "246540-787419")
  lower, upper = data.split('-').map(&:to_i)

  (lower..upper).select { |i| viable_password?(i) && one_standalone_pair?(i) }.count
end

puts "\nSolution for Part A: #{solve_a}"
puts "\nSolution for Part B: #{solve_b}"
