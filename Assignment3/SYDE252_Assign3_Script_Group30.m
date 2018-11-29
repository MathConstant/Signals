% the process of speech analysis and synthesis
clear all;
close all;

%load voice data
load('SYDE252FUN.mat');
% play the original sound
sound(y,sr);
% get the model parameters for a 40-order filter
[a,g,x] = getModel(y,20);

% synthesis voice from the estimated parameters
newY = synthVoice(a,g,1,x,1);
% play the synthesized audio signal
sound(newY,sr);

% Question 1
% add your code here, using your Fourier Transform to show 
% the spectra of the original signal and the synthesized signal
% Comment on your observation

% Build time-domain
length_original = length(y);
length_synthesized = length(newY);

tDomain_original = 0:sr:(length_original-1) * sr;
tDomain_synthesized = 0:sr:(length_synthesized-1) * sr;

% specify frequency domain to inspect with FT
w = -1000:1000;
fDomain_length = length(w);

result_original = zeros(1, fDomain_length);
for i = 1:fDomain_length
    result_original(i) = MyFT(y, tDomain_original, w(i));
end

result_synthesized = zeros(1, fDomain_length);
for j = 1:fDomain_length
    result_synthesized(j) = MyFT(newY, tDomain_synthesized, w(j));
end

plot(w, result_original)
hold on
plot(w, result_synthesized)
hold off

% end of Question 1
%% Changing the speed of the speech, without significantly modifying the tone of the speech
% play the audio at half speed
sound(y,sr/2);
% play the audio at double speed
sound(y,sr*2);
% Question 2
%I think this might be Time Expansion

% end of Question 2
% Question 3: changing the length of x, without changing its general shape
x_f = interp1(); % finish this line to generate x_f[n] for faster speech
x_s = interp1(); % finish this line to generate x_s[n] for slower speech
% end of Question 3

% synthesis voices using the x_fast and x_slow you just generated
y_f = synthVoice(a,g,1,x_f,0.5);
y_s = synthVoice(a,g,1,x_s,2);

% play the synthesized audio signal
sound(y_f,sr);
sound(y_s,sr);


%% changing the tone without changing the speed

% move the poles so the resulting system function would have a higher gain
% at higher frequencies
aHigh = myMovePoles_Group30(a,0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% higher tone, but at the same speed as the original signal
yHigh = synthVoice(aHigh,g,1,x,1);
% play the new signal
sound(yHigh,sr);


% move the poles so the resulting system function would have a higher gain
% at lower frequencies
aLow = myMovePoles_Group30(a,-0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% lower tone, but at the same speed as the original signal
yLow = synthVoice(aLow,g,1,x,1);
% play the new signal
sound(yLow,sr);
