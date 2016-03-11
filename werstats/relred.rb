#!/usr/bin/ruby
# calculate relative error rate reductions
# WERs
# These are from summary_wer.txt, except for dnnss/HG_dev and dnnss/MD_dev which die for some reason;
#  since they are only dev results I haven't debugged, instead I'm just using the results
#  for these two entries that Vimal reported, though his scoring system didn't normalize
#  length durations and silence, so the PERs are not strictly comparable

per = {}

# First entries are gmm and gmmpt, eval and dev
per[:yue]=[[68.40,68.35],[57.20,56.57]]
per[:hun]=[[68.62,66.90],[56.98, 57.26]]
per[:cmn]=[[71.30,68.66],[58.21,57.85]]
per[:swh]=[[63.04,64.73],[44.31,48.88]]
# add dnn, dnnss, and dnnpt if available
per[:yue] += [[66.59,65.41],[63.79,62.46],[53.64,53.80]]
per[:hun] += [[66.43,67.18],[63.53,63.50],[56.70, 58.45]]
per[:cmn] += [[65.77,64.80],[64.90,64.00],[54.07, 53.13]]
per[:swh] += [[65.30,65.11],[58.76,59.81],[44.73, 48.60]]
              
# now print relative error rate reductions
[:yue, :hun, :cmn, :swh].each do |lang|
  gmmptmul = {}
  gmmptss = {}
  dnnptmul = {}
  dnnptss = {}
  puts "### Relative reductions for language #{lang}:"
  0.upto(1) do |deveval|
    gmmptmul[deveval]=100*(per[lang][0][deveval]-per[lang][1][deveval])/per[lang][0][deveval]
    gmmptss[deveval]=100*(per[lang][3][deveval]-per[lang][1][deveval])/per[lang][3][deveval]
    if per[lang].size > 4 then
      dnnptmul[deveval]=100*(per[lang][2][deveval]-per[lang][4][deveval])/per[lang][2][deveval]
      dnnptss[deveval]=100*(per[lang][3][deveval]-per[lang][4][deveval])/per[lang][3][deveval]
    end
  end

  puts sprintf("gmm: %3.1f (%3.1f), %3.1f (%3.1f)",gmmptmul[0],gmmptmul[1],gmmptss[0],gmmptss[1])
  if per[lang].size > 4 then
    puts sprintf("dnn: %3.1f (%3.1f), %3.1f (%3.1f)",dnnptmul[0],dnnptmul[1],dnnptss[0],dnnptss[1])
  end
end
