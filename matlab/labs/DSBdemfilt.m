%!-------------------------------------------------------------------------------------------------
%! @file      DSBdemfilt.m
%! @author    Hunter Mills
%! @date      March 2024
%! @brief     This script uses a triangle function to demonstrate DSB modulation and demodulation.
%! @detials   The message m1(t) = tri((t+.01)/.01) - tri((t-.01)/.01)
%!-------------------------------------------------------------------------------------------------

%! Adding path to functions
addpath(genpath('functions'));

%! Script Variables
ts      = 1e-4;
fs      = 1/ts;
fc      = 300;
t       = -.04 : ts : .04;
Lfft    = length(t); Lfft = 2^ceil(log2(Lfft) + 1);
BW_m    = 150; % Bandwidth of the triangle function in Hz
f       = (-Lfft/2 : Lfft/2-1) * fs / Lfft;

%-----------------
%! Message
%-----------------
m_sig  = triangle_signal((t+.01)/.01) - triangle_signal((t-.01)/.01);
M_fre = fftshift(fft(m_sig, Lfft));

%-----------------
%! Modulation
%-----------------
s_dsb = m_sig .* cos(2*pi*fc*t);
S_dsb = fftshift(fft(s_dsb, Lfft));

%-----------------
%! Demodulation
%-----------------
% Multiply with carrier
s_dem = 2 * s_dsb .* cos(2*pi*fc*t);
S_dem = fftshift(fft(s_dem, Lfft));

% Low pass filter
h     = fir1(40, BW_m / fs);
s_rec = filter(h, 1, s_dem);
S_rec = fftshift(fft(s_rec, Lfft));

%-----------------
%! Plot
%-----------------
Trange = [-.025 .025 -2 2]; % Time domain range for plots
Frange = [-700 700 0 200];  % Frequency domain range for plots

% 1.1 Plot baseband signal in time and freq domain
figure(1)
subplot(2,1,1)
plot(t, m_sig)
title('m(t)'); ylabel('Amp'); xlabel('Time (s)'); axis(Trange);
subplot(2,1,2)
plot(f, abs(M_fre))
title('M(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% 1.2 Plot AM signal in t and f
figure(2)
subplot(2,1,1)
plot(t, s_dsb)
title('s(t)'); ylabel('Amp'); xlabel('Time (s)'); axis(Trange);
subplot(2,1,2)
plot(f, abs(S_dsb))
title('S(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% 1.3 Plot Rx signal in freq domain, filtered Rx signal in freq and time
figure(3)
subplot(3,1,1)
plot(f, abs(S_dem))
title('S_{dem}(f) Pre-filter'); ylabel('Amp'); xlabel('Freq (Hz)'); axis(Frange);
subplot(3,1,2)
plot(f, abs(S_rec))
title('S_{rec}(f) Post-filt'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);
subplot(3,1,3)
plot(t, s_rec)
title('s_{rec}(t) Post-filt'); ylabel('Amp'); xlabel('Time (s)'); axis(Trange);
