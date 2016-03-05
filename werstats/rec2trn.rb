#!/usr/bin/ruby
# rec2trn.rb
# Mark Hasegawa-Johnson, 3/4/2016
# Distributed under the CC-BY license so you can do anything you want:
#  https://creativecommons.org/licenses/by/4.0/

##############################################
USAGE='rec2trn.rb input.rec output.trn
  Convert kaldi .rec file into a NIST-format .trn file'
if ARGV.size < 2 then
  puts USAGE;
  exit
end

##############################################
# Read the ipa2worldbet conversion dictionary
# This dictionary is now also used to eliminate phone length distinctions
#  and to map !SIL to nothing
dict={}
File.open('ipa2worldbet_ref_dict.txt','r:UTF-8') do |fi|
  fi.each do |line|
    a=line.gsub(/\"/,'').chomp.split
    dict[a[1]]=a[3]
  end
end
                                                   
##############################################
inputfile=ARGV[0]
outputfile=ARGV[1]
File.open(inputfile,'r:UTF-8') do |fi|
  File.open(outputfile,'w:UTF-8') do |fo|
    fi.each do |li|
      a=li.split
      b=a.shift
      c=a.map{|x| dict.has_key?(x) ? dict[x] : x}
      fo.puts c.join(" ")+' ('+b+')'
    end
  end
end

