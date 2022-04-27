# -*- coding: utf-8 -*-


import librosa 
import librosa.display
import soundfile as sf
import matplotlib.pyplot as plt
import numpy as np

#read in audio file
filename = '../recording/rawSpeech.wav'
y, sr = librosa.load(filename,sr= None)

#create mfcc
mfcc = librosa.feature.mfcc(y=y, sr=sr)

#display the mfcc plots
librosa.display.specshow(mfcc)
plt.ylabel('MFCC')

plt.colorbar()

#save mfcc plots to result folder
plt.savefig('./result/mfcc.png')

# Passing through arguments to the Mel filters
S = librosa.feature.melspectrogram(y=y, sr=sr, n_mels=128,
                                    fmax=21500)
fig, ax = plt.subplots()
S_dB = librosa.power_to_db(S, ref=np.max)

#display melspectrogram plots
img = librosa.display.specshow(S_dB, x_axis='time',
                         y_axis='mel', sr=sr,
                         fmax=21500, ax=ax)
fig.colorbar(img, ax=ax, format='%+2.0f dB')
ax.set(title='Mel-frequency spectrogram')

#save melspectrogram plots to result folder
plt.savefig('./result/Mel-frequency spectrogram.png')

#perform inverse mfcc
audio = librosa.feature.inverse.mfcc_to_audio(mfcc,sr=sr)

#save the inversed mfcc audio to result
sf.write('./result/Raw_audio_inverse_mfcc.wav', audio, sr)