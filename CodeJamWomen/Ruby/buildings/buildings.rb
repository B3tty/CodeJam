class MyClass
  INPUT_SMALL = File.absolute_path("C-small-practice.in")
  INPUT_LARGE = File.absolute_path("C-large-practice.in")
  OUTPUT_SMALL = File.absolute_path("C-small-practice.out")
  OUTPUT_LARGE = File.absolute_path("C-large-practice.out")
  NB_ARGS = 1
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    self.handle_file(INPUT_SMALL, OUTPUT_SMALL)
    self.handle_file(INPUT_LARGE, OUTPUT_LARGE)
  end

  def self.handle_file(infile, outfile)
    raw_cases = self.read_input(infile)
    nb_cases = self.get_nb_cases(raw_cases)
    cases = self.split_inputs(raw_cases, nb_cases)
    File.open(outfile, 'w') {|out|
      cases.each_with_index do |kase, kase_index|
        out << self.run_case(kase, kase_index)
        out << "\n"
      end
    }
  end

  def self.read_input(input)
    input_file = File.new(input)
    input_string = IO.read(input_file)
    raw_cases = input_string.split(CASES_SEP)
  end

  def self.get_nb_cases(raw_cases)
    nb_cases = raw_cases.first.to_i
  end

  def self.split_inputs(raw_cases, nb_cases)
    cases = []
    current_index = 1
    for i in 0..(nb_cases - 1)
      nb_args = raw_cases[current_index].to_i
      cases[i] = raw_cases[current_index..(current_index + nb_args)]
      current_index += nb_args + 1
    end
    #cases = raw_cases[/n"1..-1]
    # puts cases.join("\n\n\n")
    return cases
  end

  def self.djikstra(source, b, distances)
    infinity = b * 3
    visited = Array.new(b, false)
    shortest_distances = Array.new(b, INFINITY)
    current = source
    for i in 1..b
      shortest_distances[i] = distance(source, i, distances)
    end
  end

  def self.distance(a, b, dists)
    if a > b
      return dists[a][b-1]
    elsif a == b
      return 0
    else
      return dists[b][a-1]
    end
  end

  def self.run_case(kase, kase_index)
    b = kase.first.to_i

    dists = {}
    for i in 2..b
      dists[i] = kase[i-1].split(" ")
    end


    # i = kase[1].to_i
    # items = kase[2].split(ITEMS_SEP).collect{|item| item.to_i}

    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{new_string}"
    return out_string
  end
end

MyClass.main