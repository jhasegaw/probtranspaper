#!/usr/bin/ruby
# calculate relative error rate reductions
# WERs
# These are from summary_wer.txt, except for dnnss/HG_dev and dnnss/MD_dev which die for some reason;
#  since they are only dev results I haven't debugged, instead I'm just using the results
#  for these two entries that Vimal reported, though his scoring system didn't normalize
#  length durations and silence, so the PERs are not strictly comparable

per = {}

# First entries are gmm and gmmpt, eval and dev
per[:yue]=[[66.5, 65.9], [54.7, 54.3]]
per[:hun]=[[63.0, 63.0], [53.0, 53.3]]
per[:cmn]=[[68.0, 64.0], [55.1, 54.0]]
per[:swh]=[[61.5, 63.2], [43.5, 48.0]]
# add dnn, dnnss, and dnnpt if available
per[:yue] += [[64.2, 62.6], [61.7, 60.2]]
per[:hun] += [[61.2, 61.9], [58.8, 63.5], [52.1, 54.1]]
per[:cmn] += [[61.3, 59.4], [60.7, 64.0], [51.2, 49.4]]
per[:swh] += [[62.8, 63.0], [56.8, 58.1], [43.9, 47.3]]

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
