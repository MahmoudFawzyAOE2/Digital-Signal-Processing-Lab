function [voice_f_filterd] = Spectrum_PSD_and_filter( signal_t, Fs )
%UNTITLED2 Summary of this function goes here
% Inputs:
%   signal_t:          Signal in Time Domain
%   Fs:                Sampling frequency
% Outputs:
%   voice_f_filterd:   Filterd signal in Frequency domain
%   Plot of both the Frequncy Spectrum & PSD (Power Spectral Density)
%   Plot of both the filter & filterd signal


% Part2 : spectrum and spectral density
N = length(signal_t);
signal_f = fft(signal_t);
signal_f = signal_f(1:N/2+1);
signal_psd = (1/(Fs*N)) * abs(signal_f).^2;
signal_psd(2:end-1) = 2*signal_psd(2:end-1);
signal_psd = 10*log10(signal_psd);
freq = 0:Fs/length(signal_t):Fs/2;

figure;
subplot(2,2,1)
plot(freq,abs(signal_f))
grid on
title('Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

subplot(2,2,2)
plot(freq,signal_psd)
grid on
title('PSD')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

% Part3 : Filter

n = 3 ;                 %filter order
wn = 4000/(Fs/2) ;
coef = fir1(n,wn) ; 

[h,w] = freqz(coef,1,length(signal_f),Fs);
filter = abs(h)';
voice_f_filterd = filter .*signal_f;


subplot(2,2,3)
plot(w ,filter)
grid on
title('filter')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

subplot(2,2,4)
plot(freq,abs(voice_f_filterd))
grid on
title('Spectrum after filter')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

%comment:
% due to the effect of the filter, the amp of spectrum reduced.
% cutoff freq = 4k , reduction in spectrum after 4k is greater.
% the higher the order , the closer the filter to Ideal filter.
end

