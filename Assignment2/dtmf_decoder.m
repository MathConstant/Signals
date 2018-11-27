load('.\Option1\DTMF1.mat');

% Takes in a signal in time domain, applies fourier transform to identify
% peaks in frequency domain. Matches these peak frequencies to dtmf lookup
% table to determine which key was pressed

% RESULT FOR DTMF1: 1-519-888-4567

Xt = acqData; % read in from dtmf1
length_xt = length(Xt);

% Data for Xt is sampled 16000 times / second; interval is 0.0000625
time_inc = 6.25e-5;
t = 0:time_inc:(length_xt-1)*time_inc;

% Given a series of tones, we will analyze each one separately to identify
% its component frequencies.

% Given DTMF1, Split tone sequence into individual components.
% By observation, these are the time domains of each peak:
% peak1: 2.2-2.6
% peak2: 3.3-3.7
% peak3: 4.3-4.6
% peak4: 5.4-5.8
% peak5: 7.1-7.4
% peak6: 8.1-8.5
% peak7: 9-9.4
% peak8: 10-10.4
% peak9: 11-11.4
% peak10: 11.9-12.2
% peak11: 12.9-13.3
% We can find the corresponding index ranges corresponding to these peaks;
% we know indices of the time vector are given by time_value * 16000 + 1
index = @(x) x * 16000 + 1;

tr1 = t(index(2.2):index(2.6));
tone1 = Xt(index(2.2):index(2.6));

tr2 = t(index(3.3):index(3.7));
tone2 = Xt(index(3.3):index(3.7));

tr3 = t(index(4.3):index(4.6));
tone3 = Xt(index(4.3):index(4.6));

tr4 = t(index(5.4):index(5.8));
tone4 = Xt(index(5.4):index(5.8));

tr5 = t(index(7.1):index(7.4));
tone5 = Xt(index(7.1):index(7.4));

tr6 = t(index(8.1):index(8.5));
tone6 = Xt(index(8.1):index(8.5));

tr7 = t(index(9):index(9.4));
tone7 = Xt(index(9):index(9.4));

tr8 = t(index(10):index(10.4));
tone8 = Xt(index(10):index(10.4));

tr9 = t(index(11):index(11.4));
tone9 = Xt(index(11):index(11.4));

tr10 = t(index(11.9):index(12.2));
tone10 = Xt(index(11.9):index(12.2));

tr11 = t(index(12.9):index(13.3));
tone11 = Xt(index(12.9):index(13.3));

% We know DTMF tone is composed of one of: 697, 770, 852, or 941 Hz signals
% combined with one of: 1209, 1336 or 1477 Hz signals.
% For each tone we will perform two fourier transforms, each covering one
% of these ranges. This lets us more easily identify a single peak in each
% transform, as well as reduce computational volume.

% Conversion to radians/sec (w = 2*pi*f):
set1 = [4379.38, 4838.05, 5541.77, 5912.48];
set2 = [7596.37, 8394.34, 9280.26];


% -------------------------------------------------------------------------
% Here, we manually go through each tone identifying the fundamental (max)
% frequencies of each and deducing the corresponding input.

% TONE1
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone1, tr1, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone1, tr1, set2(i));
end

% plot(set1, result1);
% hold on
% plot(set2, result2);

% See 'tone_peaks.pdf' for example of plot used to identify component
% frequencies. Same approach used for all subsequent tones.

% Component frequencies: 4379 & 7596
% Tone: 1


% TONE2
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone2, tr2, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone2, tr2, set2(i));
end

% Component frequencies: 4838 & 8394
% Tone: 5


% TONE3
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone3, tr3, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone3, tr3, set2(i));
end

% Component frequencies: 4379 & 7596
% Tone: 1


% TONE4
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone4, tr4, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone4, tr4, set2(i));
end

% Component frequencies: 5542 & 9280
% Tone: 9


% TONE5
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone5, tr5, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone5, tr5, set2(i));
end

% Component frequencies: 5542 & 8394
% Tone: 8


% TONE6
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone6, tr6, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone6, tr6, set2(i));
end

% Component frequencies: 5542 & 8394
% Tone: 8


% TONE7
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone7, tr7, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone7, tr7, set2(i));
end

% Component frequencies: 5542 & 9280
% Tone: 8


% TONE8
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone8, tr8, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone8, tr8, set2(i));
end

% Component frequencies: 4838 & 7596
% Tone: 4


% TONE9
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone9, tr9, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone9, tr9, set2(i));
end

% Component frequencies: 4838 & 8394
% Tone: 5


% TONE10
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone10, tr10, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone10, tr10, set2(i));
end

% Component frequencies: 4838 & 9280
% Tone: 6


% TONE11
result1 = zeros(1, length(set1));
for i = 1:length(set1)
    result1(i) = MyFT(tone11, tr11, set1(i));
end

result2 = zeros(1, length(set2));
for i = 1:length(set2)
    result2(i) = MyFT(tone11, tr11, set2(i));
end

% Component frequencies: 5542 & 7596
% Tone: 7
