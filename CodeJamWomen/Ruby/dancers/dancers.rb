class MyClass
  INPUT = File.absolute_path("B-large-practice.in")
  OUTPUT = File.absolute_path("B-large-practice.out")
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
    #cases = []
    #for i in 0..(nb_cases - 1)
    #  cases[i] = raw_cases[(i*NB_ARGS+1)..((i+1)*NB_ARGS)]
    #end
    cases = raw_cases[1..-1]
    return cases
  end

  def self.run_case(kase, kase_index)
    items = kase.split(ITEMS_SEP).collect{|item| item.to_i}

    d = items.first # number of dancers
    k = items[1]    # number of _the_ dancer
    n = items[2]    # number of turns


    if k.modulo(2) == 0
      d_pos = k-n
      dancer1 = (d_pos+1-n).modulo(d)
      dancer2 = (d_pos-1-n).modulo(d)
    else
      d_pos = k+n
      dancer1 = (d_pos+1+n).modulo(d)
      dancer2 = (d_pos-1+n).modulo(d)
    end

    dancer1 = d if dancer1 == 0
    dancer2 = d if dancer2 == 0

    new_string = "#{dancer1} #{dancer2}"
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{new_string}"
    return out_string
  end
end


MyClass.main
