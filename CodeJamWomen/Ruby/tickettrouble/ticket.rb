class MyClass
  INPUT_SMALL = File.absolute_path("A-small-attempt0.in")
  INPUT_LARGE = File.absolute_path("A-large.in")
  OUTPUT_SMALL = File.absolute_path("A-small-practice.out")
  OUTPUT_LARGE = File.absolute_path("A-large.out")
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
    current_index = 1
    for i in 0..(nb_cases - 1)
      nb_args = raw_cases[current_index].split(" ").first.to_i
      cases[i] = raw_cases[current_index..(current_index + nb_args)]
      current_index += nb_args + 1
    end
    #cases = raw_cases[/n"1..-1]
    # puts cases.join("\n\n\n")
    return cases
  end

  def self.run_case(kase, kase_index)
    f = kase.first.split(" ").first.to_i
    s = kase.first.split(" ").last.to_i

    max = 0
    seats = kase[1..f].uniq.collect{|str| str.split(" ").map(&:to_i)}
    # require 'pry'
    # binding.pry
    for i in 1..s
      num = seats.count{|seat| seat.first == i || seat.last == i}
      max = num if num > max
    end
    # items = kase[2].split(ITEMS_SEP).collect{|item| item.to_i}

    new_string = ""
    out_string = ""
    out_string = "Case ##{kase_index+1}: #{max}"
    return out_string
  end
end

MyClass.main