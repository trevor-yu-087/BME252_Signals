function Hd = exampleBPF
%EXAMPLEBPF Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and Signal Processing Toolbox 8.0.
% Generated on: 05-Jul-2019 19:56:04

% Elliptic Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

Fstop1 = 1350;     % First Stopband Frequency
Fpass1 = 1400;     % First Passband Frequency
Fpass2 = 1600;    % Second Passband Frequency
Fstop2 = 1650;    % Second Stopband Frequency
Astop1 = 60;      % First Stopband Attenuation (dB)
Apass  = 1;       % Passband Ripple (dB)
Astop2 = 60;      % Second Stopband Attenuation (dB)
match  = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match)

[y1,fs] = audioread("Taylor Swift - Our Song_trimmed_35-52.wav");
y = y1;
[b, a] = sos2tf(Hd.sosMatrix);
magScale = prod(Hd.ScaleValues)
%b = b .* magScale;
%a = a .* magScale;
soundsc(y,fs)
outfilt = filter(Hd,y);
figure(1);
x = 1:size(y);
plot(x,y);
figure(2);
plot(x,outfilt);
soundsc(outfilt,fs)
figure(3)
rec = abs(outfilt);
plot(x,rec)
hLPF = fdesign.lowpass(400, 450, 1, 80, 16000);
HdLPF = design(hLPF, 'ellip', 'MatchExactly', 'both');
envelope = filter(HdLPF,rec);
hold on
plot(x,envelope)




% [EOF]
