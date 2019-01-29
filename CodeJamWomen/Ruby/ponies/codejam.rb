class MyClass
  INPUT_SMALL = File.absolute_path("1.in")
  #INPUT_LARGE = File.absolute_path("large-practice.in")
  OUTPUT_SMALL = File.absolute_path("1.out")
  #OUTPUT_LARGE = File.absolute_path("large-practice.out")
  NB_ARGS = 1
  CASES_SEP = "\n"
  ITEMS_SEP = " "

  def self.main()
    self.handle_file(INPUT_SMALL, OUTPUT_SMALL)
     #self.handle_file(INPUT_LARGE, OUTPUT_LARGE)
  end

  def self.handle_file(infile, outfile)
    raw_cases = self.read_input(infile)
    message = "aoh yfy wcw lvrblu! qh viog tb ewph ix yqr amk. qh kqen grr wh wccvj wvrv sri eagn jc kcoz ptxe smihg o jxvtrp dfdb igf a pmijos axpibp giihette rlucqsmku.

wugzy zoqmknt, wco fov kgaq rvcv dwxo bl esldfl wg nrpjuo pmvcufc, kyoz, qm ks ecofom ipgsbks.

yo rmlfipfoxr

xm lwif js néqépzxwx, - yc jyxt, - t'bpcblgioé,
zm itiaas x'decbvavls à fd hwnt aomzch :
ai lguyc snrwtx gsg kclws, - mm ooa jink qwgutrjzé
jrfbx ne fmzylz vhkr qc zu pézigeoygs.

xdba ec nhgh xx hwfdens, hil ecb o'af achvcté,
kgnqq-ail zm icufgzcsdm xv ln ksl g'wbtnir,
jo zosck suv nzulgibv tnlh à grb khgue bégioé,
sb ec tecwfos wù eg pnkdlh à zi kqsr q'ofowm.

lwif-hs upcck qu cfépov ?... zclkgayb ix pqkqn ?
zmb zucvm gsg pcojs mgeoe bi vdwaxt dr jo lhwvx ;
l'av pêjé xdba ec gemhnh cù vtie yy gcuèbm...

xv j'ng ryxl nhks iywhtimnt teyjyugé t'tehéemb :
grrcecng rcou à hwnt shp zu omzx f'oenvéy
osa lqucgfm gs tt uavlhy hh txu cegg xh zi yég.

ig'q pydibbhuy ggh'w wb?
uwt jywn, wc ebp, ybs vuys bh io ucfy /ggifhdf?ybmzsz=[yklyuwnkhpxcnfusl]&dibavoxcb=[ovsghwrgmyyq] ovw rrbtwxh ovlyee rc nks cevizyhy timlvibl cz ownx, vhr sbcyszlg, aab sphfgmjiae!"

    File.open(outfile, 'w') {|out|
      #cases.each_with_index do |kase, kase_index|
        out << decrypt(message)
        out << "\n"
      #end
    }
  end

  def self.read_input(input)
    input_file = File.new(input)
    input_string = IO.read(input_file)
    raw_cases = input_string
  end

  
  def self.decrypt(message)
    result = ""
    map = "canyoudoit"
    length = map.size
    i = 0
    regex ="/[^a-zA-Z]$/"
    message.each_char{ |n|
      if n =~ regex 
        result.insert(-1, ((n.downcase.ord - map[i % length].ord) % 26 + 'a'.ord).chr)
        i++
      else
        result.insert(-1, ' ')
      end
    }
    return result
  end
  
  end


MyClass.main