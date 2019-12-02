require_relative "solution_helper"
include SolutionHelper

def parse_data(data)
  data.split(",").map(&:to_i)
end

def run_intcode(data, position)
  code, a, b, val = data[position...position + 4]

  if code == 99
    return data
  elsif code == 1
    data[val] = data[a] + data[b]
  elsif code == 2
    data[val] = data[a] * data[b]
  end

  run_intcode(data, position + 4)
end

def solve_a(data = default_data_file(__FILE__))
  data = parse_data(data)
  data[1] = 12
  data[2] = 2

  run_intcode(data, 0)[0]
end

def solve_b(data = default_data_file(__FILE__))
  init_data = parse_data(data)

  (0...100).each do |noun|
    (0...100).each do |verb|
      data = init_data.dup
      data[1] = noun
      data[2] = verb

      solved_intcode = run_intcode(data, 0)

      return (100 * noun + verb) if solved_intcode[0] == 19690720
    end
  end
end

expect([2,0,0,0,99], run_intcode([1,0,0,0,99], 0), [1,0,0,0,99])
expect([30,1,1,4,2,5,6,0,99], run_intcode([1,1,1,4,99,5,6,0,99], 0), "1,1,1,4,99,5,6,0,99")

puts "\nSolution for Part A: #{solve_a}"

puts "\nSolution for Part B: #{solve_b}"
