class MyClass
  INPUT_SMALL = File.absolute_path("A-small-practice.in")
  INPUT_LARGE = File.absolute_path("A-large-practice.in")
  OUTPUT_SMALL = File.absolute_path("A-small-practice.out")
  OUTPUT_LARGE = File.absolute_path("A-large-practice.out")
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
      cases[i] = raw_cases[current_index..current_index + nb_args]
      current_index = current_index + nb_args + 1
    end
    #cases = raw_cases[1..-1]
    return cases
  end

  def self.run_case(kase, kase_index)
    n = kase.first.to_i
    ropes = kase[1..-1].map{|r| r.split(ITEMS_SEP).collect{|item| item.to_i}}
    intersections = 0

    ropes[0..-2].each_with_index do |r1, i|
      ropes[i+1..-1].each do |r2|
        intersections = intersections + intersect(r1, r2)
      end
    end

    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{intersections}"
    return out_string
  end

  def self.intersect(r1, r2)
    a1 = r1.first
    b1 = r1.last
    a2 = r2.first
    b2 = r2.last

    if a1 < a2
      return 1 if b1 > b2
    else
      return 1 if b1 < b2
    end
    return 0
  end
end


MyClass.main
