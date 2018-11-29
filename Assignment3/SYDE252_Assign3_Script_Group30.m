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
% length_original = length(y);
% length_synthesized = length(newY);
% 
% tDomain_original = 0:sr:(length_original-1) * sr;
% tDomain_synthesized = 0:sr:(length_synthesized-1) * sr;
% 
% % specify frequency domain to inspect with FT
% w = -1000:1000;
% fDomain_length = length(w);
% 
% result_original = zeros(1, fDomain_length);
% for i = 1:fDomain_length
%     result_original(i) = MyFT(y, tDomain_original, w(i));
% end
% 
% result_synthesized = zeros(1, fDomain_length);
% for j = 1:fDomain_length
%     result_synthesized(j) = MyFT(newY, tDomain_synthesized, w(j));
% end
% 
% plot(w, result_original)
% hold on
% plot(w, result_synthesized)
% hold off

% end of Question 1
%% Changing the speed of the speech, without significantly modifying the tone of the speech
% play the audio at half speed
sound(y,sr/2);
% play the audio at double speed
sound(y,sr*2);
% Question 2
% The property that explains why tone is lowered when the audio is played at half speed is the time-scaling property.  
% According to this property, when a function is expanded in time by a factor a "a", its Fourier Transform is compressed in frequency by “a”. 
% 
% x(t/a) -> aX(?a)
% 
% Lower frequencies have a lower pitch therefore an increases in time will make the output signal sound lower and vice versa.

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
sound(y_f,sr);
sound(y_s,sr);


%% changing the tone without changing the speed

% move the poles so the resulting system function would have a higher gain
% at higher frequencies
aHigh = myMovePoles(a,0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% higher tone, but at the same speed as the original signal
yHigh = synthVoice(aHigh,g,1,x,1);
% play the new signal
sound(yHigh,sr);


% move the poles so the resulting system function would have a higher gain
% at lower frequencies
aLow = myMovePoles(a,-0.2);
% synthesis the speech with the new system and the original x[n], resulting in a speech with
% lower tone, but at the same speed as the original signal
yLow = synthVoice(aLow,g,1,x,1);
% play the new signal
sound(yLow,sr);