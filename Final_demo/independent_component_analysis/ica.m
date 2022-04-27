clear all; clc,

%read in two audio files
[first, fs] = audioread('../recording/Original_professor.wav');
[second, fs] = audioread('../recording/Original_student.wav');

num_sample = min([size(first,1) size(second,1)]);

mixed = zeros(num_sample,2);

t = 1:num_sample;
t = t.';

%determine the sample size
if num_sample == size(first,1)
    second = second(1:num_sample,1);
    first = first(:,1);
else
    first = first(1:num_sample,1);
    second = second(:,1);
end

%mix two audio together
mixed(:,1) = first(:,1);
mixed(:,2) = second(:,1);

mixdata = mixed*randn(2) + randn(1,2);

%prewhitened the mixed audio
mixdata = prewhiten(mixdata);

%create ica model
mdl = rica(mixdata, 2,'NonGaussianityIndicator',ones(2,1));

%transform the mixed audio to two unmixed audio
z = transform(mdl, mixdata);

%find the unmixed audio respectively 
%based on their difference between the orginal audio

diff_first = abs(sum(z(:,1) - first));
diff_second = abs(sum(z(:,2) - second));

if diff_first < diff_second
    unmixed_first = z(:,1);
    unmixed_second = z(:,2);
else
    unmixed_first = z(:,2);
    unmixed_second = z(:,1);
end

%output the unmixed audio and mixed audio to result folder
audiowrite('../independent_component_analysis/result/Random_mix.wav', mixdata, fs);
audiowrite('../independent_component_analysis/result/Unmixed_First.wav', unmixed_first, fs);
audiowrite('../independent_component_analysis/result/Unmixed_Second.wav', unmixed_second, fs);

%show plots
figure();
plot(t./fs, mixdata(:,1));
title('Random Mix');
xlabel('Time');


figure();
subplot(2,2,1);
plot(t./fs, first);
title('Original First');
xlabel('Time');
subplot(2,2,3);
plot(t./fs, unmixed_first);
title('Unmixed First');
xlabel('Time');

subplot(2,2,2);
plot(t./fs, second);
title('Original Second');
xlabel('Time');
subplot(2,2,4);
plot(t./fs, unmixed_second);
title('Unmixed Second');
xlabel('Time');

%% mixed recording
clear all; clc;

%read in mixed audio recording
[recording, fs] = audioread('../recording/two_person_speech.wav');

num_sample = size(recording, 1);

mixed = zeros(num_sample,2);

t = 1:num_sample;
t = t.';

%create a audio for second column for ica 
mixed(:,1) = recording;
mixed(:,2) = recording + randn(1,1);

%prewitened the audio
mixdata = prewhiten(mixed);

%create ica model
mdl = rica(mixdata, 2,'NonGaussianityIndicator',ones(2,1));

%output two signals
z = transform(mdl, mixdata);

%output mixed audio and two unmixed audio to result folder
audiowrite('./result/Random_mix.wav', mixdata, fs);
audiowrite('./result/Unmixed_speaker1.wav', z(:,1), fs);
audiowrite('./result/Unmixed_speaker2.wav', z(:,2), fs);

figure();
plot(t./fs, recording);
title('Original Recording');
xlabel('Time');


figure();
subplot(1,2,1);
plot(t./fs, z(:,1));
title('Unmixed Recording 1');
xlabel('Time');
subplot(1,2,2);
plot(t./fs, z(:,2));
title('Unmixed Recording 2');
xlabel('Time');



