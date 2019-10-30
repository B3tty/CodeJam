class MyClass
  INPUT_SMALL = File.absolute_path("1-small-practice.in")
  #INPUT_LARGE = File.absolute_path("1-large-practice.in")
  OUTPUT_SMALL = File.absolute_path("1-small-practice.out")
  #OUTPUT_LARGE = File.absolute_path("1-large-practice.out")
  NB_ARGS = 1
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    self.handle_file(INPUT_SMALL, OUTPUT_SMALL)
    #self.handle_file(INPUT_LARGE, OUTPUT_LARGE)
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
    for i in 0..(nb_cases - 1)
      cases[i] = raw_cases[(i*NB_ARGS+1)..((i+1)*NB_ARGS)]
    end
    #cases = raw_cases[1..-1]
    return cases
  end

  def self.run_case(kase, kase_index)
    items = kase.first.split(ITEMS_SEP).collect{|item| item.to_i}
    r = items.first
    c = items[1]

    rows = (1..r).to_a
    columns = (1..c).to_a

    cells = rows.product(columns).to_a

    journeys = cells.permutation

    possibility = nil
    solution = nil


    journeys.each do |j|
      if is_compliant(j)
        possibility = "POSSIBLE"
        solution = j
        break
      end
    end

    possibility = possibility || "IMPOSSIBLE"

    out_string = ""
    out_string = "Case ##{kase_index+1}: #{possibility}"
    out_string << print_solution(solution) if solution
    return out_string
  end

  def self.is_step_compliant(r, c, r2, c2)
    return (r != r2) && (c != c2) && (r-c != r2-c2) && (r+c != r2+c2)
  end

  def self.is_compliant(journey)
    (0..(journey.length() -2)).each do |i|
      unless (is_step_compliant(journey[i][0], journey[i][1], journey[i+1][0], journey[i+1][1]))
        return false
      end
    end
    return true
  end

  def self.print_solution(solution)
    str = ""
    solution.each do |step|
      str << "\n"
      str << step.join(" ")
    end
    str
  end
end

MyClass.main