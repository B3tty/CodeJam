class MyClass
  INPUT = File.absolute_path("D-small-2-attempt0.in")
  OUTPUT = File.absolute_path("D-small-2-attempt0.out")
  NB_ARGS = 2
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
    n = kase.first.to_i
    pwds = kase[1].split(ITEMS_SEP)

    alphabet = [*?A..?Z]

    new_string = ""

    pwds.each do |pwd|
      if pwd.size == 1
        new_string = "IMPOSSIBLE"
        break
      end

      pwd = pwd.split(//)

      letter1 = pwd.first
      letter2 = pwd.find{|l| l != letter1}

      if letter2
        index1 = alphabet.index(letter1)
        index2 = alphabet.index(letter2)

        p_index1 = pwd.index(letter1)
        p_index2 = pwd.index(letter2)

        if p_index1 < p_index2
          alphabet[index1], alphabet[1] = alphabet[1], alphabet[index1]
          alphabet[index2], alphabet[0] = alphabet[0], alphabet[index2] unless (index2 == 1 && index1 == 0)
        else
          alphabet[index1], alphabet[0] = alphabet[0], alphabet[index1]
          alphabet[index2], alphabet[1] = alphabet[1], alphabet[index2]
        end
      else
        alphabet[0], alphabet[1] = alphabet[1], alphabet[0]
      end
    end

    new_string = alphabet.join unless new_string != ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{new_string}"
    return out_string
  end
end


MyClass.main
