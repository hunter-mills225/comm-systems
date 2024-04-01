%!-------------------------------------------------------------------------------------------------
%! @file      AMdemfilt.m
%! @author    Hunter Mills
%! @date      March 2024
%! @brief     This script uses a triangle function to demonstrate AM modulation and demodulation.
%! @detials   The message m1(t) = tri((t+.01)/.01) - tri((t-.01)/.01)
%!-------------------------------------------------------------------------------------------------

%! Adding path to functions
addpath(genpath('functions'));

%! Script Variables
ts    = 1e-4;
fs    = 1/ts;
fc    = 500;
t     = -.04 : ts : .04;
Lfft  = length(t); Lfft = 2^ceil(log2(Lfft) + 1);
BW_m  = 150; % Bandwidth of the triangle function in Hz
f     = (-Lfft/2 : Lfft/2-1) * fs / Lfft;

%-----------------
%! Message
%-----------------
m_sig = triangle_signal((t+.01)/.01) - triangle_signal((t-.01)/.01);
M_sig = fftshift(fft(m_sig, Lfft));

%-----------------
%! Modulation
%-----------------
% AM signal is created by adding DC offset to DSB (DC causes carrier in the Tx signal)
s_am  = (2/3 + m_sig) .* cos(2*pi*fc*t);
S_am  = fftshift(fft(s_am, Lfft));

%-----------------
%! Demodulation
%-----------------
% Demodulation starts with rectifier
s_dem = s_am .* (s_am > 0);
S_dem = fftshift(fft(s_dem, Lfft));

% Low pass filter
h     = fir1(40, BW_m*ts);
s_rec = filter(h, 1, s_dem);
S_rec = fftshift(fft(s_rec, Lfft));

%-----------------
%! Plot
%-----------------
Trange = [-.025 .025 -2 2]; % Time domain range for plots
Frange = [-700 700 0 200];  % Frequency domain range for plots

% 1.4 AM signal in  time and freq
figure(1)
subplot(2,1,1)
plot(t, s_am)
title('s_{am}(t)'); ylabel('Amp'); xlabel('Time (s)'); axis(Trange);
subplot(2,1,2)
plot(f, abs(S_am))
title('S_{am}(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% 1.5 Rectifed and Demodulated signal in time
figure(2)
subplot(2,1,1)
plot(t, s_dem)
title('s_{dem}(t)'); ylabel('Amp'); xlabel('Time (s)'); axis(Trange);
subplot(2,1,2)
plot(t, s_rec)
title('s_{rec}(t)'); ylabel('Amp'); xlabel('Time (s)'); axis([-.025 .025 -.5 1]);




