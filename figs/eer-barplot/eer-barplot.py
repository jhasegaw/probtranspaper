# -*- coding: utf-8 -*-
"""
===============================================================================
Script 'eer-barplot'
===============================================================================

This script makes a barplot of JSALT equal-error-rate data.
"""
# @author: drmccloy
# Created on Wed Mar  9 14:45:08 2016
# License: BSD (3-clause)

from __future__ import division, print_function
import numpy as np
from scipy.io import loadmat
from expyfun.analyze import barplot
import matplotlib.pyplot as plt
plt.ioff()

# params
nreps = 20
lang_order = np.array((0, 2, 1))  # eng, nld, hin
feats = ('Continuant', 'Sonorant', 'Del. Rel.', 'Voiced',
         'Aspirated', 'Labial', 'Coronal', 'Dorsal')
feat_names = ['\n' + n if ix % 2 else n + '\n' for ix, n in enumerate(feats)]
# EER matrix dims (from readme): repetition, testLanguage, kFold, feature
id_ = loadmat('EER_ID.mat')['EER']   # (50, 3, 4, 8)
bars = id_[:nreps].mean(-2)    # average over kFold
bars = bars[:, lang_order, :]  # arrange languages in order: eng, nld, hin
bars = bars.swapaxes(-1, -2)   # transpose last 2 dims
bars = bars.reshape(-1, 24)    # flatten last two axes (keep "repetition")
# grouping indices
groups = np.arange(bars.shape[-1]).reshape(-1, 3)
# plot it
fig = plt.figure(figsize=(6.5, 2.75))
ax = plt.Axes(fig, [0.1, 0.2, 0.875, 0.7])
fig.add_axes(ax)
p, b = barplot(bars, axis=0, err_bars='sd', groups=groups, gap_size=0.5,
               bar_names='', ylim=(0.2, 0.6), group_names=feat_names,
               ax=ax, bar_kwargs=dict(color=('0.3', '0.6', '0.9')))
p.yaxis.set_label_text('Equal Error Rate')
p.yaxis.set_ticks(np.linspace(0.2, 0.6, 5))
xmin, xmax = p.get_axes().get_xlim()
p.hlines(0.5, xmin, xmax, linestyles='--')
#plt.tight_layout()
ax.legend(b.get_children()[:3], ('English', 'Dutch', 'Hindi'), loc=(0.8, 0.8),
          fontsize=10)
plt.draw()
fig.savefig('eer-barplot.pdf')
