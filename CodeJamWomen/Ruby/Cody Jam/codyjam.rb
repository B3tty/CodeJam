class MyClass
  INPUT_SMALL = File.absolute_path("A-small-attempt0.in")
  INPUT_LARGE = File.absolute_path("A-large.in")
  OUTPUT_SMALL = File.absolute_path("A-small-attempt0.out")
  OUTPUT_LARGE = File.absolute_path("A-large.out")
  NB_ARGS = 2
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    #self.handle_file(INPUT_SMALL, OUTPUT_SMALL)
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
    items = kase[1].split(ITEMS_SEP).collect{|item| item.to_i}

    sale = []
    for i in 1..n
      my_item = items[0]
      sale << my_item
      full_price = my_item * 4/3
      full_index = items.index(full_price)
      items.delete_at(full_index)
      items.delete_at(0)
    end

    new_string = sale.join(" ")
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{new_string}"
    return out_string
  end
end


MyClass.main
