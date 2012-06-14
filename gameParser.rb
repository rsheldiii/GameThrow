class Parser


  def initialize(file)
    @keywordMap = {}
    f = File.open(file,'r')
    args = []
    while line = f.gets
      args.push(line)
    end
    
    args.each do |line|
      line = line.chomp
      keyword = line.slice(/(.*)?=/,1)
      keymap = line.slice(/=(.*)/,1)
      number = '(?<number>[0-9]{1,2})'
      undo = '(?<undo>u)?'#question mark added because optional undo will always be optional. undo command is it's own function and not included in this
      possession = '(?<possession>[ah])'
      case keyword
      when "shotAndMadeFreeThrow"
        first = keymap.slice(/(.*),/,1)
        second = keymap.slice(/,(.*)/,1)
        puts first,second
        @keywordMap["shotAndMadeFreeThrow"] = Regexp.new('\b'+undo+first+number+second+'\b')
        @keywordMap["shotFreeThrow"] = Regexp.new('\b'+undo+first+number+'\b')
      when "shotAndMade3Pointer"
        first = keymap.slice(/(.*),/,1)
        second = keymap.slice(/,(.*)/,1)
        puts first,second
        @keywordMap["shotAndMade3Pointer"] = Regexp.new('\b'+undo+first+number+second+'.*?(2)?\b')#should theoretically allow for sating "tptr32t3", which shouldnt happen, because we already knew it was a 3 ptr
        @keywordMap["shot3Pointer"] = Regexp.new('\b'+undo+first+number+'\b')
      when "shotAndMade2Pointer"
        first = keymap.slice(/(.*),/,1)
        second = keymap.slice(/,(.*)/,1)
        puts first,second
        @keywordMap["shotAndMade3Pointer"] = Regexp.new('\b'+undo+first+number+second+'.*?(3)?\b')#should theoretically allow for sating "tptr32t3", which shouldnt happen, because we already knew it was a 3 ptr
        @keywordMap["shot3Pointer"] = Regexp.new('\b'+undo+first+number+'\b')
      when "stopClock"
        @keywordMap["stopClock"] = Regexp.new('\b'+undo+keymap+'\b')#no undo
      when "startClock"
        @keywordMap["startClock"] = Regexp.new('\b'+undo+keymap+'\b')#no undo
      when "printPlayer"
        @keywordMap["printPlayer"] = Regexp.new('\b'+undo+keymap+number+'\b')#no undo
      when "resetPossession"
        @keywordMap["resetPossession"] = Regexp.new('\b'+undo+keymap+possession+'.*\b')
      when "undo"
        @keywordMap["undo"] = Regexp.new('\bu\b')
      end
    end
  end

  def parse(line)
    @keywordMap.each { |function,regexp|
      if line =~ regexp
        return {"function" => function,"regexp" =>regexp.match(line)}
      end
      }
    return nil
  end
  
end