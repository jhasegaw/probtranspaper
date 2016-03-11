#!/bin/sh
# Compare each pair of systems
SCLITE=/cygdrive/c/Users/Mark/Dropbox/packages/sctk-2.4.10/bin/sclite
if [ ! -d aln ]; then mkdir aln; fi
for d in gmmpt gmmptss dnnss dnnpt dnnptss; do
    if [ ! -d aln/$d ]; then mkdir aln/$d; fi
done

for L in CA HG MD SW; do
    for C in dev eval; do
	# GMM vs GMMPT
	echo '####' ${SCLITE} -i swb -h trn/gmm/gmm_${L}_${C}.trn -i swb -h trn/gmmpt/gmmpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/gmmpt -o pra -o sum -o sgml
	${SCLITE} -i swb -h trn/gmm/gmm_${L}_${C}.trn -i swb -h trn/gmmpt/gmmpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/gmmpt -o pra -o sum -o sgml
	# DNN vs DNNSS
	echo '####' ${SCLITE} -i swb -h trn/dnn/dnn_${L}_${C}.trn -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -r trn/ref/ref_${L}_${C}.trn -O aln/dnnss -o pra -o sum -o sgml
	${SCLITE} -i swb -h trn/dnn/dnn_${L}_${C}.trn -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -r trn/ref/ref_${L}_${C}.trn -O aln/dnnss -o pra -o sum -o sgml
	# GMMPT vs DNNSS
	echo '####' ${SCLITE} -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -i swb -h trn/gmmpt/gmmpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/gmmptss -o pra -o sum -o sgml
	${SCLITE} -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -i swb -h trn/gmmpt/gmmpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/gmmptss -o pra -o sum -o sgml
	# DNN vs DNNPT
	echo '####' ${SCLITE} -i swb -h trn/dnn/dnn_${L}_${C}.trn -i swb -h trn/dnnpt/dnnpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/dnnpt -o pra -o sum -o sgml
	${SCLITE} -i swb -h trn/dnn/dnn_${L}_${C}.trn -i swb -h trn/dnnpt/dnnpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/dnnpt -o pra -o sum -o sgml
	# DNNSS vs. DNNPT
	echo '####' ${SCLITE} -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -i swb -h trn/dnnpt/dnnpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/dnnptss -o pra -o sum -o sgml
	${SCLITE} -i swb -h trn/dnnss/dnnss_${L}_${C}.trn -i swb -h trn/dnnpt/dnnpt_${L}_${C}.trn -i swb -r trn/ref/ref_${L}_${C}.trn -O aln/dnnptss -o pra -o sum -o sgml
    done
done

