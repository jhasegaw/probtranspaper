#!/bin/sh
# Convert .rec files to .trn
DATA='/cygdrive/c/Users/Mark/Dropbox/grants/clsp/ws15/'
if [ ! -d trn ]; then mkdir trn; fi
for d in ref gmm gmmpt dnn dnnss dnnpt; do
    if [ ! -d trn/$d ]; then mkdir trn/$d; fi
done
for L in CA HG MD SW; do
    for C in dev eval; do
	echo ${L}_${C}
	# ref
	./rec2trn.rb ${DATA}/haotang/SBS-mul-${L}/data/${L}/${C}/text trn/ref/ref_${L}_${C}.trn
	# GMM
	./rec2trn.rb ${DATA}/haotang/SBS-mul-${L}/exp/tri3b/decode_${C}_text_G_${L}/scoring_kaldi/penalty_0.0/9.txt trn/gmm/gmm_${L}_${C}.trn
	# GMM PT
	./rec2trn.rb ${DATA}/cliu/SBS-mul-${L}-icassp/exp/tri3b_map_${L}_*/decode_${C}/scoring_kaldi/penalty_0.0/9.txt trn/gmmpt/gmmpt_${L}_${C}.trn
	# DNN
	./rec2trn.rb ${DATA}/haotang/SBS-mul-${L}/exp/dnn4_pretrain-dbn_dnn/decode_${C}_text_G_${L}/scoring_kaldi/penalty_0.0/4.txt trn/dnn/dnn_${L}_${C}.trn
	# DNN SS
	./rec2trn.rb ${DATA}/vmanohar/SBS-mul-${L}/exp/dnn5_pretrain-dbn_dnn_semisup/decode_text_G_${C}_${L}/scoring_kaldi/penalty_0.0/4.txt trn/dnnss/dnnss_${L}_${C}.trn
	# DNN PT
	./rec2trn.rb ${DATA}/vmanohar/dnnpt/dnn_pt_${C}_${L}.rec trn/dnnpt/dnnpt_${L}_${C}.trn
    done
done


