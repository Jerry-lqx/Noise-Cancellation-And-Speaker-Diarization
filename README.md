# Noise-Cancellation-And-Speaker-Diarization

This is the final demonstration for noise cancellation and speaker diarization system for EECS351: Digital Signal Processing at University of Michigan

In the recording directory, it contains five audio files that we used for testing
  * Original_professor.wav is a short audio file that only a professor is talking
  * Original_student.wav is a short audio file that only a student is talking
  * rawSpeech.wav is a one-minute speech recorded by Raj Patel in a coffe shop
  * rawSpeechfiltered.wav is a filtered audio of rawSpeech.wav that is used for mel frequency cepstral coefficient (MFCC)
  * two_person_speech.wav is a 30-seconds speech recorded by Qianxu Li and Tianwei Liu in a noisy place

There are five different algorithms you can perform

For Noise Cancellation:
  * Go to noise cancellation directory
  * The matlab code allows you to choose any '.wav' audio file for processing
  * It will output two filtered recordings and the files will be saved in the result directory
  * The audio file ends in '-filtered' is the output from adaptive bandpass filter only
  * The audio file ends in '-wavdeced' is the output from adaptive bandpass filter and wave decomposition
  * The result directory contains the filtered audios for rawSpeech.wav

For Independent Component Analysis:
  * Go to independent component analysis directory
  * The first section of the matlab code will take Original_professor.wav and Original_student.wav as two input audio files
  * The algorith will linearly mixed two signals into one random_mix audio
  * Independent Component Analysis will look for the inverse matrix and separate the random_mix into two unmixed audio signals
  * Finally, it will display plots for analysis and save the random_mix audio, and two unmixed audio signals as "Random_mix.wav", "Unmixed_First.wav" and "Unmixed_second.wav" in the result directory

  * The second section of the matlab code will take two_person_speech.wav as the input audio file
  * The algorithm will try to separate two speakers using Independent Component Analysis
  * It will save two unmixed audio signals as "Unmixed_Speaker1.wav" and "Unmixed_Speaker2.wav" in the result directory

For Speaker Diarization:
  * Go to speaker diarization directory
  * The python code takes two_person_speech.wav as input audio file
  * It will separate the speakers using spectral cluster
  * It will save two speeches as "speaker_1.wav" and "speaker_2.wav" in the result directory

For MFCC in matlab:
  * Go to MFCC directory
  * The first section takes "rawSpeech.wav" as input audio file
  * It will display the melspectrogram of the signal
  * The second section takes "rawSpeechfiltered.wav" as input audio file
  * It will display the melspectrogram of the filtered signal for comparison

For MFCC in python:
  * Go to MFCC_using_librosa directory
  * The algorithm takes "two_person_speech.wav" as input audio file
  * It will produce the MFCC of the signal and save the MFCC and melspectrogram as "mfcc.png" and "Mel-frequency spectrogram.png" in the result directory
  * The algorithm reconstructs the audio signal from MFCC
  * The audio signal will be saved as "two_person_speech_inverse_mfcc.wav" in the result directory
