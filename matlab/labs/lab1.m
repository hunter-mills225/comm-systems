%!--------------------------------------------------------------------------------------------------
%! @file      lab1.m
%! @author    Hunter Mills
%! @date      Febuary 2024
%! @brief     Steps : 
%!              1 : Plot over -5:5 seconds
%!                  1 Hz sine wave 
%!                  Unit rectangle 
%!                  Unit triangle
%!              2 : Plot each singal with
%!                  a) Time sift of .5 seconds
%!                  b) Time Scaling with compression of 3
%!              3 : Signal Spectra
%!                  a) Plot spectrum of signals in 1 and 2b
%!                  b) Plot and observe the spectrum of tonal voice
%!                  c) Plot spectrum of another wave file
%!
%!--------------------------------------------------------------------------------------------------

%! Adding path to functions
addpath(genpath('functions'));

%! Create Signals for step (1)
t           = linspace(-5, 5, 5000);
sin_wave    = sin(2*pi*t);
rect        = rectangle_signal(t, -.5, .5, 0);
tri         = triangle_signal(t);

%! Plot Signals from step (1)
figure(1);
subplot(3, 1, 1);
plot(t, sin_wave)
xlabel('Time (s)')
ylabel('Amplitude (v)')
ylim([-1.5, 1.5])
title('1Hz Sine Wave')
subplot(3, 1, 2);
plot(t, rect)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Rectangluar Signal')
ylim([0, 1.5])
subplot(3, 1, 3);
plot(t, tri)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Triangle Signal')
ylim([0, 1.5])

%! Create signals for step (2a)
sin_delay  = sin(2*pi*(t - .5));
rect_delay = rectangle_signal(t, -.5, .5, .5);
tri_delay  = triangle_signal(t-.5);

%! Plot Signals from step (2a)
figure(2);
subplot(3, 1, 1);
plot(t, sin_delay)
xlabel('Time (s)')
ylabel('Amplitude (v)')
ylim([-1.5, 1.5])
title('1Hz Sine Wave Time Shifted by .5s')
subplot(3, 1, 2);
plot(t, rect_delay)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Rectangluar Signal Time Shifted by .5s')
ylim([0, 1.5])
subplot(3, 1, 3);
plot(t, tri_delay)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Triangle Signal Time Sifted by .5s')
ylim([0, 1.5])

%! Create signals for step (2b)
sin_com  = sin(2*pi*(t*3));
rect_com = rectangle_signal(t*3, -.5, .5, 0);
tri_com = triangle_signal(t*3);

%! Plot Signals from step (2b)
figure(3);
subplot(3, 1, 1);
plot(t, sin_com)
xlabel('Time (s)')
ylabel('Amplitude (v)')
ylim([-1.5, 1.5])
title('1Hz Sine Wave Time Compressed by 3')
subplot(3, 1, 2);
plot(t, rect_com)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Rectangluar Signal Time Compressed by 3')
ylim([0, 1.5])
subplot(3, 1, 3);
plot(t, tri_com)
xlabel('Time (s)')
ylabel('Amplitude (v)')
title('Triangle Signal Time Compressed by 3')
ylim([0, 1.5])

%! Create signals from step (3a)
fs              = 500;
L               = 5000;
f               = fs * (-L/2:L/2-1)/L;
sin_fft         = fftshift(abs(fft(sin_wave)));
rect_fft        = fftshift(abs(fft(rect)));
tri_fft         = fftshift(abs(fft(tri)));
sin_fft_comp    = fftshift(abs(fft(sin_com)));
rect_fft_comp   = fftshift(abs(fft(rect_com)));
tri_fft_comp    = fftshift(abs(fft(tri_com)));

%! Plot Signals from step (3a)
figure(4);
subplot(2, 1, 1);
plot(f, sin_fft)
xlabel('Frequency (Hz')
ylabel('Magnitude')
xlim([-5, 5])
title('1Hz Sine Wave Spectrum')
subplot(2, 1, 2);
plot(f, sin_fft_comp)
xlabel('Frequency (Hz')
ylabel('Magnitude')
title('1Hz Sine Wave Spectrum after Time Compression by 3')
xlim([-5, 5])
figure(5);
subplot(2, 1, 1);
plot(f, rect_fft)
xlabel('Frequency (Hz')
ylabel('Magnitude')
xlim([-150, 150])
title('Rectangular Signal Spectrum')
subplot(2, 1, 2);
plot(f, rect_fft_comp)
xlabel('Frequency (Hz')
ylabel('Magnitude')
xlim([-150, 150])
title('Rectangular Signal Spectrum after Time Compression by 3')
figure(6);
subplot(2, 1, 1);
plot(f, tri_fft)
xlabel('Frequency (Hz')
ylabel('Magnitude')
title('Triangular Signal Spectrum')
xlim([-100, 100])
subplot(2, 1, 2);
plot(f, tri_fft_comp)
xlabel('Frequency (Hz')
ylabel('Magnitude')
title('Triangular Signal Spectrum after Time Compression by 3')
xlim([-100, 100])

%! Plot Tonal voice (3b)
[tonal, tonal_fs] = audioread("sounds/tonal_voice.wav");
figure(7)
f = tonal_fs * (-length(tonal)/2:length(tonal)/2-1)/length(tonal);
plot(f, fftshift(abs(fft(tonal(:, 1)))))
title('Spectrum of Toanl Voice')
xlabel('Frequency (Hz)')
ylabel('Amp')
xlim([-5000, 5000])

%! Plot (3c)
[song, fs] = audioread("sounds/jimi_hendrix_guitar.wav");
figure(8)
f = fs * (-length(song)/2:length(song)/2-1)/length(song);
plot(f, fftshift(abs(fft(song(:, 1)))))
title('Spectrum of Jimi Hendrix Guitar')
xlabel('Frequency (Hz)')
ylabel('Amp')
xlim([-10000, 10000])
