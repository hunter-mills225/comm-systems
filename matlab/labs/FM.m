%!-------------------------------------------------------------------------------------------------
%! @file      FM.m
%! @author    Hunter Mills
%! @date      March 2024
%! @brief     This script uses a triangle function to demonstrate FM modulation and demodulation.
%! @detials   The message m1(t) = tri((t+.01)/.01) - tri((t-.01)/.01)
%!-------------------------------------------------------------------------------------------------

%! Adding path to functions
addpath(genpath('functions'));

%! Script Variables
ts    = 1e-4;
fs    = 1/ts;
fc    = 300;
t     = -.04 : ts : .04;
Lfft  = length(t); Lfft = 2^ceil(log2(Lfft) + 1);
BW_m  = 100; % Bandwidth of the triangle function in Hz
f     = (-Lfft/2 : Lfft/2-1) * fs / Lfft;

%-----------------
%! Message
%-----------------
m_sig = triangle_signal((t+.01)/.01) - triangle_signal((t-.01)/.01);
M_sig = fftshift(fft(m_sig, Lfft));

%-----------------
%! Modulation
%-----------------
kf      = 160 * pi * 2;
m_intg  = kf * ts * cumsum(m_sig);
s_fm    = cos(2*pi*fc*t + m_intg);
s_pm    = cos(2*pi*fc*t + pi*m_sig);
S_fm    = fftshift(fft(s_fm, Lfft));
S_pm    = fftshift(fft(s_pm, Lfft));

%-----------------------
%! FM Demodulation
%-----------------------
s_fmdem = diff([s_fm(1) s_fm]) * fs / kf;   % Not sure why we diff sample 1 with its self
S_fmdem = fftshift(fft(s_fmdem, Lfft));
s_fmrec = s_fmdem .* (s_fmdem > 0);         % Rectifier
S_fmrec = fftshift(fft(s_fmrec, Lfft));

% Low pass filter
h       = fir1(80, BW_m*ts);
s_dec   = filter(h, 1, s_fmrec);

%-----------------
%! Plots
%-----------------
Frange = [-700 700 0 200];  % Frequency domain range for plots

% 2.1 FM signal in time and frequency
figure(1)
subplot(2,1,1)
plot(t, s_fm)
title('s_{fm}(t)'); ylabel('Amp'); xlabel('Time (s)');
subplot(2,1,2)
plot(f, abs(S_fm))
title('S_{fm}(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% 2.2 PM signal in time and frequency
figure(2)
subplot(2,1,1)
plot(t, s_pm)
title('s_{pm}(t)'); ylabel('Amp'); xlabel('Time (s)');
subplot(2,1,2)
plot(f, abs(S_pm))
title('S_{pm}(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% Test
figure(3)
subplot(2,1,1)
plot(t, s_fmdem)
title('s_{fmdem}(t)'); ylabel('Amp'); xlabel('Time (s)');
subplot(2,1,2)
plot(f, abs(S_fmdem))
title('S_{fmdem}(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);
figure(4)
subplot(2,1,1)
plot(t, s_fmrec)
title('s_{fmrec}(t)'); ylabel('Amp'); xlabel('Time (s)');
subplot(2,1,2)
plot(f, abs(S_fmrec))
title('S_{fmrec}(f)'); ylabel('Amp'); xlabel('Frequency (Hz)'); axis(Frange);

% 2.3 Demodulated FM in time
figure(5)
subplot(2,1,1)
plot(t, m_sig)
title('s_{dec}_(t)'); ylabel('Amp'); xlabel('Time (s)');
subplot(2,1,2)
plot(t, s_dec)
title('s_{dec}(t)'); ylabel('Amp'); xlabel('Time (s)');







