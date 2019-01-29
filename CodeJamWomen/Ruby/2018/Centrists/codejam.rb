class MyClass
  INPUT_SMALL = File.absolute_path("C-small-attempt0.in")
  INPUT_LARGE = File.absolute_path("C-large-practice.in")
  OUTPUT_SMALL = File.absolute_path("C-small-attempt0.out")
  OUTPUT_LARGE = File.absolute_path("C-large-practice.out")
  NB_ARGS = 2
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
    cases.each do |c|
        puts c
        puts "\n"
    end
    return cases
  end

  def self.run_case(kase, kase_index)
    c = kase.first.to_i
    names = kase[1].split(ITEMS_SEP)
    
    alphabet = ["C", "B", "A"]
    perms = alphabet.permutation
    
    ok = ["NO", "NO", "NO"]
    
    
    perms.each do |order|
        ordered_names = order(names, order)
        final_order = names.collect{|name| ordered_names.index(name)}
        ok[final_order.index(1)] = "YES"
    end
    
    ordered_names = order(names, alphabet)
    

    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{ok.join(" ")}"
    return out_string
  end
  
  def self.order(names, order)
    aux_names = names.dup
    aux_names.collect!{|name| name_to_value(name, order)}
    aux_names.sort!
    aux_names.collect!{|name| name.split("").collect{|letter| order[letter.to_i]}.join}
    return aux_names
  end 
  
  def self.name_to_value(name, alphabet)
    name.split("").collect{|letter| alphabet.index(letter)}.join
  end
end

MyClass.main