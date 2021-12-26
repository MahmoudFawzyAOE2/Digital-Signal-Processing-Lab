%%
clc
clear all
%% Part1-a :  Generate double tone sinusoidal signal

Fs = 16000;
time_start = 0;
time_end = 1;
t =linspace(time_start,time_end,(time_end - time_start)*Fs);

f_1 = 3000;
f_2 = 5000;
signal_t = 0.2*( sin(2*pi*f_1*t) + sin(2*pi*f_2*t) );

Spectrum_PSD_and_filter( signal_t,Fs )


%% Part1-b : Read Voice signal from file & repeat

% reading the audio file
[voice_t,fs_voice]= audioread ('Arslan.wav');

voice_f_filterd = Spectrum_PSD_and_filter( voice_t',fs_voice );

voice_f_filterd = [fliplr(voice_f_filterd) , voice_f_filterd];
voice_t_filterd = abs(ifft(voice_f_filterd));
% play the edited audio file
sound(voice_t_filterd',fs_voice)

% play the audio file
sound (voice_t,fs_voice)

%% Part2 : Time domain


Fs_2 = 20000;
time_start = 0;
time_end = 0.1;
t2 =linspace(time_start,time_end,(time_end - time_start)*Fs_2);

f_1 = 100;
f_2 = 2000;
f_3 = 7000;
signal2_t = 0.2*( sin(2*pi*f_1*t2) + sin(2*pi*f_2*t2) + sin(2*pi*f_3*t2) );

%% Part2 : Filter & plots

LPF = [1.0000 0.7303 0.5334 0.3895 0.2845 0.2077 0.1517 0.1108 0.0809 0.0591 0.0432 0.0315 0.023 0.0168 0.0123 0.009 0.0065 0.0048 0.0035 0.0026 0.0019 0.0014 0.001 0.0007];

%filterd signal in t
signalo_t = conv(signal2_t,LPF);
t_y = linspace(time_start,time_end,((time_end - time_start)*Fs_2)+length(LPF)-1);

%oringinal signal in f
N2 = length(signal2_t);
signal2_f = fft(signal2_t);
signal2_f = signal2_f(1:N2/2+1);
freq2 = 0:Fs_2/length(signal2_t):Fs_2/2;

%filterd signal in f
No = length(signalo_t);
signalo_f = fft(signalo_t);
signalo_f = signalo_f(1:No/2+1);
freqo = 0:Fs_2/length(signalo_t):Fs_2/2;

figure;
subplot(2,2,1)
plot(t2,signal2_t)
grid on
title('input signal in time')
xlabel('Time (sec)')
ylabel('Amplitude')

subplot(2,2,2)
plot(t_y,signalo_t)
grid on
title('output signal in time')
xlabel('Time (sec)')
ylabel('Amplitude')

subplot(2,2,3)
plot(freq2,abs(signal2_f))
grid on
title('input signal in freq')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

subplot(2,2,4)
plot(freqo,abs(signalo_f))
grid on
title('output signal in freq')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

% comment 
% in freq domain, the lower the freq, the higher the amplitude. 
% because the signal is covolved with a LPF.

% this also appeare in the time domain,
% the output sine appeare to maintain lower freq

