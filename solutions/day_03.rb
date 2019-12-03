require_relative "solution_helper"
include SolutionHelper

DIRECTION_PROC = {
  'R' => (->(distance) { [distance, 0] }),
  'L' => (->(distance) { [-distance, 0] }),
  'U' => (->(distance) { [0, -distance] }),
  'D' => (->(distance) { [0, distance] }),
}

def create_path_to_point(a, b)
  a.zip(b).map do |(s, e)|
    e < s ? s.downto(e).to_a : s.upto(e).to_a
  end.reduce(:product)[1..-1]
end

def create_wire(path)
  path.inject([]) do |result, (direction, distance)|
    change = DIRECTION_PROC[direction].call(distance.to_i)
    current_pos = result.last || [0, 0]
    end_pos = [current_pos, change].transpose.map { |x| x.reduce(:+) }

    result + create_path_to_point(current_pos, end_pos)
  end
end

def solve_a(data = default_data_file(__FILE__))
  path_a, path_b = data.split("\n").map { |s| create_wire(s.scan(/(\w)(\d+)/)) }

  (path_a & path_b).map { |point| point.map(&:abs).reduce(:+) }.min
end

def solve_b(data = default_data_file(__FILE__))
  path_a, path_b = data.split("\n").map { |s| create_wire(s.scan(/(\w)(\d+)/)) }

  (path_a & path_b).map { |point| path_a.index(point) + path_b.index(point) }.min + 2
end

expect(159, solve_a("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"), "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")

puts "\nSolution for Part A: #{solve_a}"

expect(610, solve_b("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"), "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")

puts "\nSolution for Part B: #{solve_b}"
