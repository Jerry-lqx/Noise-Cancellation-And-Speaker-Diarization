# -*- coding: utf-8 -*-

from resemblyzer import preprocess_wav, VoiceEncoder
from pathlib import Path
import librosa
import numpy as np
import soundfile as sf
from spectralcluster import SpectralClusterer

def create_labelling(labels,wav_splits):
    from resemblyzer import sampling_rate
    times = [((s.start + s.stop) / 2) / sampling_rate for s in wav_splits]
    labelling = []
    start_time = 0

    for i,time in enumerate(times):
        if i>0 and labels[i]!=labels[i-1]:
            temp = [str(labels[i-1]),start_time,time]
            labelling.append(tuple(temp))
            start_time = time
        if i==len(times)-1:
            temp = [str(labels[i]),start_time,time]
            labelling.append(tuple(temp))

    return labelling

#give the file path to your audio file
audio_file_path = '../recording/two_person_speech.wav'
wav_fpath = Path(audio_file_path)

#embed the audio file to produce d-vectors
wav = preprocess_wav(wav_fpath)
encoder = VoiceEncoder("cpu")
_, cont_embeds, wav_splits = encoder.embed_utterance(wav, return_partials=True, rate=16)
print(cont_embeds.shape)

#create spectralcluster for speaker diarization
clusterer = SpectralClusterer(
    min_clusters=2,
    max_clusters=7)

#perform labels for different speakers
labels = clusterer.predict(cont_embeds)

labelling = create_labelling(labels,wav_splits)

#load orignal recording for speech separation
y, sr = librosa.load(audio_file_path, sr = None)
num_row = len(y)

#preset the length of each array
time = [i for i in range(num_row)]

speaker_1 = [0 for i in range(num_row)];
speaker_2 = [0 for i in range(num_row)];

#based on the labelling, overwrite each speaker at time t
#label 0 is speaker_1 and label 1 is speaker_2 by default
for labels in labelling:
  if labels[0] == "0":
    for t in range(round(sr * labels[1]), round(sr * labels[2]) + 1):
      speaker_1[t] = y[t]

  if labels[0] == "1":
    for t in range(round(sr * labels[1]), round(sr * labels[2]) + 1):
      speaker_2[t] = y[t]

#output two audio files to result
sf.write('./result/speaker_1.wav', speaker_1, sr)
sf.write('./result/speaker_2.wav', speaker_2, sr)