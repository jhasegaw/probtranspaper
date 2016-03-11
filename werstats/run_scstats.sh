#!/bin/sh
# Compare each pair of systems
SCSTATS=/cygdrive/c/Users/Mark/Dropbox/packages/sctk-2.4.10/bin/sc_stats
if [ ! -d stats ]; then mkdir stats; fi
for d in gmmpt gmmptss dnnss dnnpt dnnptss; do
    if [ ! -d stats/$d ]; then mkdir stats/$d; fi
done

# gmmpt, gmmptss, dnnss, dnnpt, and dnnptss
for L in CA HG MD SW; do
    for C in dev eval; do
	for d in gmmpt gmmptss dnnss dnnpt dnnptss; do
	    cat aln/${d}/*_${L}_${C}.trn.sgml | ${SCSTATS} -p -O stats/$d -t std4 -n ${d}_${L}_${C} -v
	done
    done
done
