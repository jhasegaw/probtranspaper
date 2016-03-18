# -*- coding: utf-8 -*-
"""
===============================================================================
Script 'conf-mat.py'
===============================================================================

This script loads and plots confusion matrix data from the JSALT experiment.
"""
# @author: drmccloy
# Created on Wed Mar  9 14:45:08 2016
# License: BSD (3-clause)

from __future__ import division, print_function
import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rcParams
from scipy.io import loadmat
plt.ioff()

colormap = 'gray_r'  # 'YlGnBu_r'  the _r reverses the scale
labelsize = 8
rcParams['font.family'] = 'M+ 1c'
savefig = True

# table of IPA segments x features
feats = pd.read_csv('phoible-segments-features.tsv', sep='\t',
                    encoding='utf-8')
feats = feats.set_index('segment')

# data from feature-based confusion matrix
img = loadmat('confPhoible.mat')
eng = [x[0] for x in np.squeeze(img['x'])]
nld = [y[0] for y in np.squeeze(img['y'])]
img = img['A'].T
# remove  "ɑɻ" (not in PHOIBLE feature matrix)
eng_mask = np.array([x in feats.index for x in eng])
nld_mask = np.array([x in feats.index for x in nld])
eng = np.array(eng)[eng_mask].tolist()
nld = np.array(nld)[nld_mask].tolist()
distmat = pd.DataFrame(img[eng_mask, :][:, nld_mask], columns=nld, index=eng)

# initialize plot
fig = plt.figure(figsize=(6.5, 3))
ax = plt.Axes(fig, [0.092, 0.1, 0.369, 0.7])
ax.set_frame_on(False)
fig.add_axes(ax)
plt.tick_params(axis='both', which='both', bottom='off', top='off', left='off',
                right='off', labelleft='on', labeltop='on', labelright='off',
                labelbottom='off', pad=12)
plt.tick_params(axis='both', which='minor', pad=2)
ax.xaxis.set_label_position('top')
# plot feature-based confusion matrix
_ = ax.pcolor(np.flipud(distmat.values), cmap=plt.get_cmap(colormap))
_ = ax.set_xticks(np.arange(distmat.shape[1])[::2] + 0.5, minor=False)
_ = ax.set_xticks(np.arange(distmat.shape[1])[1::2] + 0.5, minor=True)
_ = ax.set_yticks(np.arange(distmat.shape[0])[::2] + 0.5, minor=False)
_ = ax.set_yticks(np.arange(distmat.shape[0])[1::2] + 0.5, minor=True)
ax.set_xticklabels(distmat.columns[::2], minor=False, size=labelsize)
ax.set_xticklabels(distmat.columns[1::2], minor=True, size=labelsize)
ax.set_yticklabels(distmat.index[::-2], minor=False, size=labelsize)
ax.set_yticklabels(distmat.index[:-1][::-2], minor=True, size=labelsize)
ax.set_xlabel('Dutch phones')
ax.set_ylabel('English phones')


# EEG BASED CONFUSION MATRIX
img = loadmat('confEEG.mat')
eng = [x[0] for x in np.squeeze(img['x'])]
nld = [y[0] for y in np.squeeze(img['y'])]
img = img['A'].T
# remove  "ɑɻ" (not in PHOIBLE feature matrix)
eng_mask = np.array([x in feats.index for x in eng])
nld_mask = np.array([x in feats.index for x in nld])
eng = np.array(eng)[eng_mask].tolist()
nld = np.array(nld)[nld_mask].tolist()
eeg_distmat = pd.DataFrame(img[eng_mask, :][:, nld_mask], columns=nld,
                           index=eng)

# initialize plot
ax = plt.Axes(fig, [0.592, 0.1, 0.369, 0.7])
ax.set_frame_on(False)
fig.add_axes(ax)
plt.tick_params(axis='both', which='both', bottom='off', top='off', left='off',
                right='off', labelleft='on', labeltop='on', labelright='off',
                labelbottom='off', pad=12)
plt.tick_params(axis='both', which='minor', pad=2)
ax.xaxis.set_label_position('top')
# plot EEG-based confusion matrix
_ = ax.pcolor(np.flipud(eeg_distmat.values), cmap=plt.get_cmap(colormap))
_ = ax.set_xticks(np.arange(distmat.shape[1])[::2] + 0.5, minor=False)
_ = ax.set_xticks(np.arange(distmat.shape[1])[1::2] + 0.5, minor=True)
_ = ax.set_yticks(np.arange(distmat.shape[0])[::2] + 0.5, minor=False)
_ = ax.set_yticks(np.arange(distmat.shape[0])[1::2] + 0.5, minor=True)
ax.set_xticklabels(distmat.columns[::2], minor=False, size=labelsize)
ax.set_xticklabels(distmat.columns[1::2], minor=True, size=labelsize)
ax.set_yticklabels(distmat.index[::-2], minor=False, size=labelsize)
ax.set_yticklabels(distmat.index[:-1][::-2], minor=True, size=labelsize)
ax.set_xlabel('Dutch phones')
ax.set_ylabel('English phones')

if savefig:
    plt.savefig('confusion-matrices.pdf')
else:
    plt.ion()
    plt.show()


# extra stuff
'''
feat_names = ['continuant', 'sonorant', 'delayedRelease',
              'periodicGlottalSource', 'spreadGlottis', 'labial',
              'coronal', 'dorsal']
# EEG classifier results
xID_PLDA = np.array([[0.3540, 0.3778, 0.3982, 0.3391,
                      0.2731, 0.4228, 0.4112, 0.3220],
                     [0.6604, 0.5642, 1.0000, 0.4746,
                      0.4705, 0.4465, 0.4917, 0.5924],
                     [0.4550, 0.3635, 0.4555, 0.4339,
                      0.4106, 0.4128, 0.4659, 0.5137]])
xID_PLDA[xID_PLDA > 0.5] = 1 - xID_PLDA[xID_PLDA > 0.5]
xID_PLDA = pd.DataFrame(xID_PLDA, columns=feat_names,
                        index=['eng', 'nld', 'hin'])
# make conf matrix
eeg_distmat = make_dist_mat(eng_phone_feats[feat_names],
                            nld_phone_feats[feat_names],
                            weights=xID_PLDA.loc['nld'])

# only the consonants used in the EEG exp
eng_cons = [u'p', u't', u'k', u'pʰ', u'tʰ', u'kʰ', u'tʃ', u'tʃʰ', u'f', u'θ',
            u'ʃ', u'v', u'ð', u'z', u'm', u'n', u'l', u'ɹ']
nld_cons = [u'p', u't', u'ɣ', u'pʰ', u'tʰ', u'kʰ', u'tʃʰ', u'f', u'ʃ', u'v',
            u'z', u'm', u'n', u'l', u'ʀ', u'j']
eng_eeg_feats = feats.loc[eng_cons][feat_names]
nld_eeg_feats = feats.loc[nld_cons][feat_names]
# from phoible: only the (contrastive) phonemes
eng_phoible = []
nld_phoible = []
with open('english-phonemes-phoible.tsv', 'r') as csvfile:
    for row in csv.reader(csvfile, delimiter='\t'):
        eng_phoible.append(row[0].decode('utf-8'))
with open('dutch-phonemes-phoible.tsv', 'r') as csvfile:
    for row in csv.reader(csvfile, delimiter='\t'):
        nld_phoible.append(row[0].decode('utf-8'))
'''
