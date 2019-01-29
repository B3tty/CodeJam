class MyClass
  INPUT_SMALL = File.absolute_path("B-small-attempt0.in")
  INPUT_LARGE = File.absolute_path("B-large.in")
  OUTPUT_SMALL = File.absolute_path("B-small-attempt0.out")
  OUTPUT_LARGE = File.absolute_path("B-large.out")
  NB_ARGS = 2
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    # self.handle_file(INPUT_SMALL, OUTPUT_SMALL)
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
    for i in 0..(nb_cases - 1)
      cases[i] = raw_cases[(i*NB_ARGS+1)..((i+1)*NB_ARGS)]
    end
    #cases = raw_cases[1..-1]
    return cases
  end

  def self.run_case(kase, kase_index)
    n = kase.first.to_i
    probas = kase[1].split(" ").map(&:to_f)
    people = n*2
    probas.sort!
    roles = []
    for i in 0..(n-1)
      roles << [probas[i], probas[people-1-i]]
    end
    # require 'pry'
    # binding.pry


    full_proba = 1
    roles.each{|a, b| full_proba = full_proba * (1 - (a*b))}

    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{full_proba}"
    return out_string
  end
end

MyClass.main