require_relative "solution_helper"
include SolutionHelper

def parse_data(data)
  data.split(",").map(&:to_i)
end

def run_intcode(data, position, input)
  code = data[position]

  code_array = code.to_s.split('')

  jump =
    if ["3", "4"].include?(code_array.last)
      2
    elsif ["5", "6"].include?(code_array.last)
      3
    else
      4
    end

  a, b, val = data[position + 1...position + jump]

  if code_array.length > 2
    code = code_array.pop(2).join("").to_i
    mode_1 = code_array.pop
    mode_2 = code_array.pop || 0
    mode_3 = code_array.pop || 0

    opt_a = (mode_1.to_i == 0) ? data[a] : a
    opt_b = (mode_2.to_i == 0) ? data[b] : b if b
  end

  if code == 99
    return data
  elsif code == 1
    data[val] = (opt_a || data[a]) + (opt_b || data[b])
  elsif code == 2
    data[val] = (opt_a || data[a]) * (opt_b || data[b])
  elsif code == 3
    data[a] = input
  elsif code == 4
    puts opt_a || data[a]
  elsif code == 5
    new_position = (opt_b || data[b]) if (opt_a || data[a]) != 0
  elsif code == 6
    new_position = (opt_b || data[b]) if (opt_a || data[a]) == 0
  elsif code == 7
    data[val] = (opt_a || data[a]) < (opt_b || data[b]) ? 1 : 0
  elsif code == 8
    data[val] = (opt_a || data[a]) == (opt_b || data[b]) ? 1 : 0
  end

  run_intcode(data, new_position || position + jump, input)
end

def solve_a(data = default_data_file(__FILE__))
  data = parse_data(data)

  run_intcode(data, 0, 1);
  # run(data)
  nil
end

def solve_b(data = default_data_file(__FILE__))
  data = parse_data(data)

  run_intcode(data, 0, 5);
  # run(data)
  nil
end

puts "\nSolution for Part A: #{solve_a}"

puts "\nSolution for Part B: #{solve_b}"
