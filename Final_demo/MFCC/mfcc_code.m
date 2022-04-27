clear all; clc;

[audioIn,fs] = audioread("../recording/rawSpeech.wav"); % read recorded sample audio file
[coeffs,delta,deltaDelta,loc] = mfcc(audioIn,fs); % calculates Mel Frequency Cepstral Coefficients 
figure();
indi_channel = coeffs(:,:,1); %extracts coefficents from the fiorst channel calculated by mfcc.
melSpectrogram(indi_channel,fs) %plots the melspectrogram using the coefficients form the first channel  at sample frequency fs

figure();
second_channel = coeffs(:,:,2); %extracts coefficents from the second channel calculated by mfcc.
melSpectrogram(second_channel,fs) %extracts coefficents in the second channel calculated by mfcc  at sample frequency fs

figure();
melSpectrogram(audioIn,fs)  %plots the mfcc coefficents in the second channel calculated by mfcc at sample frequency fs

title('Raw Speech Melspectrogram')

%converting mel to hertz 
targated_coeffs = indi_channel(5,:); % extracting coefficients form the fifth mel bank
targated_freqs = mel2hz(targated_coeffs); % converting the fifth bank's coefficients to hertz


%%
[audioIn_Fitl,fs_Fitl] = audioread("../recording/rawSpeechFiltered.wav"); % read recorded high pass filtered audio file
[coeffsFitl,deltaFitl,deltaDeltaFitl,locFitl] = mfcc(audioIn_Fitl,fs_Fitl); % calculates Mel Frequency Cepstral Coefficients 
figure()
indi_channel_Fitl = coeffsFitl(:,:,1); %extracts coefficents from the first channel calculated by mfcc.
melSpectrogram(indi_channel_Fitl,fs_Fitl) %plots the melspectrogram using the coefficients form the first channel at sample frequency fs

figure()
melSpectrogram(audioIn_Fitl,fs_Fitl)  %plots the mfcc coefficients of the input suido at sample frequency fs
title('Filtered Speech Melspectrogram')

%converting mel to hertz 
targated_coeffs_Fitl = indi_channel_Fitl(5,:); % extracting coefficients form the fifth mel bank
targated_freqs_Fitl = mel2hz(targated_coeffs_Fitl); % converting the fifth bank's coefficients to hertz