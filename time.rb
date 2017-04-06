@cities = { "Baker Island" => ["-12:00", false], "Midway Atoll" => ["-11:00", false], "Honolulu" => ["-10:00", false],
  "Anchorage" => ["-09:00", true], "Los Angeles" => ["-08:00",true], "Salt Lake City" => ["-07:00",true],
  "Kansas City" => ["-06:00",true], "New York City" => ["-05:00", true], "Puerto Rico" => ["-04:00",false],
  "Rio de Janeiro" => ["-03:00",false], "Fernando de Noronha" => ["-02:00",false], "Ponta Delgada" => ["-01:00",true],
  "London" => ["+00:00",true], "Berlin" => ["+01:00",true], "Athens" => ["+02:00",true], "Istanbul" => ["+03:00",false],
  "Dubai" => ["+04:00",false], "Karachi" => ["+05:00",false], "Myanmar" => ["+06:00",false], "Bangkok" => ["+07:00",false],
  "Beijing" => ["+08:00",false], "Tokyo" => ["+09:00",false], "Melbourne" => ["+10:00",false], "Guadualcanal" => ["+11:00",false],
  "Wake Island" => ["+12:00",false]}

def prompt
  puts "___________________________"
  puts "Choose an option:\n1) Use system time\n2) Use Internet (NIST) time\n3) Quit"
  option = gets.to_i
  if option == 1 then
    if Time.now.inspect =~ /^(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)/ then
      year = $1.to_i
      month = $2.to_i
      day = $3.to_i
      hour = $4.to_i
      min = $5.to_i
      sec = $6.to_i
      dst = Time.now.isdst
      process(year,month,day,hour,min,sec,dst)
    end

  elsif option == 2 then
    require "socket"
    time = TCPSocket.new("time-c.nist.gov", 13).read
    #                 year    month   day     hour    minute  second  dst
    if time =~ /^\d* (\d{2})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2}) (\d{2})/ then
      year = ("20"+$1).to_i
      month = $2.to_i
      day = $3.to_i
      hour = $4.to_i
      min = $5.to_i
      sec = $6.to_i
      dst = false
      if $7.to_i == 50 then
        dst = true
      end
      process(year,month,day,hour,min,sec,dst)
    else
      puts "internet time error"
    end

  elsif option == 3 then
    puts "Exiting..."
    exit

  else
    puts "Invalid option"
    prompt
  end
end

def process(year,month,day,hour,min,sec,dst)
  inc_sec = 0
  while true
    buf = "___________________________\n"
    @cities.each do |city,atr|
      off = @cities[city][0].to_i
      if @cities[city][1] == dst then
        off += 1
      end
      off = off*(60*60)
      mod = Time.new(year,month,day,hour,min,sec) + off + inc_sec
      buf += mod.strftime("(UTC #{@cities[city][0]}) %H:%M:%S in #{city}\n")
    end
    $stdout.write "#{buf}"
    inc_sec += 1
    sleep 1
  end
end

prompt
