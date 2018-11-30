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

% Build time domains
length_original = length(y);
length_synthesized = length(newY);
time_inc = 1/sr; % sr is sample rate in Hz, time btwn samples = 1/sr
tDomain_original = 0:time_inc:(length_original-1) * time_inc;
tDomain_synthesized = 0:time_inc:(length_synthesized-1) * time_inc;

% plot(tDomain_original, y);

% specify frequency domain to inspect with FT
w = 0:10; % INCREASE THIS TO VIEW FTs (try 500:1500!)
fDomain_length = length(w);

result_original = zeros(1, fDomain_length);
result_synthesized = zeros(1, fDomain_length);
for i = 1:fDomain_length
    result_original(i) = MyFT(y, tDomain_original, w(i));
    result_synthesized(i) = MyFT(newY, tDomain_synthesized, w(i));
end

% UNCOMMENT THESE TO VIEW FTs
% figure, plot(w, abs(result_original))
% hold on
% plot(w, abs(result_synthesized))
% hold off

% end of Question 1
%% Changing the speed of the speech, without significantly modifying the tone of the speech
% play the audio at half speed
sound(y,sr/2);
% play the audio at double speed
sound(y,sr*2);

% Question 2
% *Playing the audio signal with a lower sample rate is equivalent to
% increasing the time interval between data points*

% The property that explains why tone is lowered when the audio is played
% at half speed is the time-scaling property.
% According to this property, when a function is expanded in time by a
% factor of "a", its Fourier Transform is compressed in frequency by “a”.
% In other words, 'stretching' the signal in time domain leads to a lower
% frequency, and 'compressing' in time domain leads to a higher frequency.
% 
% x(t/a) -> aX(wa)
% 
% Lower frequencies have a lower pitch therefore an expansion in time will
% make the output signal sound lower and vice versa.

% end of Question 2


% Question 3: changing the length of x, without changing its general shape

xqf = 1:2:length(x)*2;
x_f = interp1(x, xqf); % finish this line to generate x_f[n] for faster speech

% Since the slow signal takes twice the domain as x, we perform two interps
% to ensure we don't lose the second half
xqs1 = 1:0.5:length(x)*0.5;
x_s1 = interp1(x, xqs1); % finish this line to generate x_s[n] for slower speech

xqs2 = length(x)*0.5:0.5:length(x);
x_s2 = interp1(x, xqs2);

x_s = [x_s1, x_s2];

% end of Question 3

% synthesis voices using the x_fast and x_slow you just generated
y_f = synthVoice(a,g,1,x_f,0.5);
y_s = synthVoice(a,g,1,x_s,2);

% play the synthesized audio signal
% UNCOMMENT SOUNDS TO COMPARE

%sound(y,sr/2); % their slow
%sound(y,sr); % original

sound(y_s,sr); % our slow

%sound(y,sr*2); % their fast
%sound(y,sr); % original

sound(y_f,sr); % our fast

%% changing the tone without changing the speed

% move the poles so the resulting system function would have a higher gain
% at higher frequencies
aHigh = myMovePoles_Group30(a,0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% higher tone, but at the same speed as the original signal
yHigh = synthVoice(aHigh,g,1,x,1);
% play the new signal
sound(yHigh,sr);
%sound(y,sr); % original

% move the poles so the resulting system function would have a higher gain
% at lower frequencies
aLow = myMovePoles_Group30(a,-0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% lower tone, but at the same speed as the original signal
yLow = synthVoice(aLow,g,1,x,1);
% play the new signal
sound(yLow,sr);
%sound(y,sr); % original
