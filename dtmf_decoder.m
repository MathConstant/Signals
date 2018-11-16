load('.\Option1\DTMF1.mat');

% Takes in a signal in time domain, applies fourier transofrm to identify
% peaks in frequency domain. Matches these peak frequencies to dtmf lookup
% table to determine which key was pressed

Xt = acqData;
length_xt = length(Xt);

% Data for Xt is sampled 16000 times / second; interval is 0.0000625
time_inc = 6.25e-5;
t = 0:time_inc:(length_xt-1)*time_inc;

% We know frequencies of interest for DTMF range from 697 to 1447 Hz.

% We know DTMF tone is composed of one of: 697, 770, 852, or 941 Hz signals
% combined with one of: 1209, 1336 or 1477 Hz signals.
% We will perform two fourier transforms, each covering one of these
% ranges. This let's us more easily identify a single peak in each
% transform, as well as reducing computational volume.

% Conversion to radians/sec (w = 2*pi*f):
% set1 = [4379.38, 4838.05, 5541.77, 5912.48]
% set2 = [7596.37, 8394.34, 9280.26]

% Transform 1:
w1=4200:6000;
result1 = zeros(1, length(w1));

for i = 1:length(w1)
    result1(i) = MyFT(Xt, t, w(i));
end

plot(w1, result1);