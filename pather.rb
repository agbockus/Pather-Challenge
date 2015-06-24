# Created by Andrew Bockus

class Pather
  def initialize(input, output)
    @input = input
    @output = output

    @input_array = []
    @hash_indexes = []
  end

  def get_input
    if File.open(@input, "r").each_line do |line|
        @input_array << line
      end
    else
      puts "ERROR: Could not open specified input file for reading"
    end
  end

  def set_output
    if @output_file = File.open(@output, "w")

    else
      puts "ERROR: Could not open specified output file for writing"
    end
  end

  def find_hashes
    for row in 0..@input_array.length - 1
      for col in 0..@input_array[row].length - 1
        if @input_array[row][col] == '#'
          @hash_indexes.push [row.to_i, col.to_i]
        end
      end
    end
  end

  def draw_vertical_lines
    @hash_indexes.take(@hash_indexes.length-1).each_with_index do |hash_index, current_index|
      for row in hash_index[0]..@hash_indexes[current_index+1][0]
        if @input_array[row][hash_index[1]] != '#'
          @input_array[row][hash_index[1]] = '*'
        end
      end
    end
  end

  def draw_horizontal_lines
    @hash_indexes.take(@hash_indexes.length-1).each_with_index do |hash_index, current_index|
      if hash_index[1] < @hash_indexes[current_index+1][1]
        for col in hash_index[1]..@hash_indexes[current_index+1][1]
          if @input_array[@hash_indexes[current_index+1][0]][col] != '#'
            @input_array[@hash_indexes[current_index+1][0]][col] = '*'
          end
        end
      elsif hash_index[1] > @hash_indexes[current_index+1][1]
        for col in @hash_indexes[current_index+1][1]..hash_index[1]
          if @input_array[@hash_indexes[current_index+1][0]][col] != '#'
            @input_array[@hash_indexes[current_index+1][0]][col] = '*'
          end
        end
      end
    end
  end

  def run
    get_input
    set_output

    find_hashes

    draw_vertical_lines
    draw_horizontal_lines

    @output_file.puts(@input_array)
  end
end

if ARGV.length == 2
  Pather.new(ARGV[0], ARGV[1]).run
else
  puts "ERROR: Incorrect number of files specified, please specify 2 files - input and output"
end
