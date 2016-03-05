#!/usr/bin/ruby
chars = {}
ARGV.each do |filename|
  STDERR.puts "Reading from #{filename}"
  File.open(filename,'r:UTF-8') do |fi|
    fi.each do |line|
      a = line.chomp.split
      a.pop # assumes we should get rid of last word, filename
      a.each {|x| chars[x]=true}
    end
  end
end
charset = chars.keys.sort
File.open('ipa2worldbet_dict.txt','w:UTF-8') do |fo|
  chars.each do |k,v|
    fo.puts '[ "'+k+'" , "a" ]'
  end
end
