class MyClass
  INPUT = File.absolute_path("C-small-1-attempt0.in")
  OUTPUT = File.absolute_path("C-small-1-attempt0.out")
  NB_ARGS = 1
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    self.handle_file(INPUT, OUTPUT)
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
    kase1 = kase.first.split(" ")
    c = kase1.first.to_i
    v = kase1[1].to_i
    l = kase1[2].to_i

    pos = ["v", "c"]

    if l == 1
      pos = ["v"]
    else
      for i in 1..(l - 2)
        new_pos = []
        pos.each do |p|
          if p.end_with?("c")
            new_pos << "#{p}#{'v'}"
          else
            new_pos << "#{p}#{'v'}"
            new_pos << "#{p}#{'c'}"
          end
        end
        pos = new_pos
      end
    end

    new_string = pos.size.modulo(1000000007)
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{new_string}"
    return out_string
  end
end


MyClass.main
