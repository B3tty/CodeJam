class MyClass
  INPUT_SMALL = File.absolute_path("C-small-attempt1.in")
  INPUT_LARGE = File.absolute_path("C-large.in")
  OUTPUT_SMALL = File.absolute_path("C-small-attempt1.out")
  OUTPUT_LARGE = File.absolute_path("C-large.out")
  NB_ARGS = 1
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
    d = kase.first.split(" ").first.to_i
    n = kase.first.split(" ").last.to_i
    
    puts "YOU'RE SCREWED" if n > (d/3)*d

    max_words = d/3
    remaining = n
    lines = []

    line = 1
    strings = ["I/O", "I/O", "O/I", "O/I"]
    while (remaining > max_words)
      lines << strings[line.modulo(4)]*max_words
      remaining -= max_words
      line +=1
    end
    lines << "#{strings[line.modulo(4)] * remaining}#{"/" * ((max_words-remaining)*3)}" unless remaining == 0

    lines << "I" if lines.empty?
    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}:\n#{lines.join("\n")}"
    return out_string
  end
end

MyClass.main