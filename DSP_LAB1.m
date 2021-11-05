%%
clc
clear all
%% user input
% The User Will enter the number of keys
N_keys = input('Number of pressed keys...\n');

% The user will enter the keys themselves
keys = input('Enter the keys..\n','s');


letters =        ['A' 'B' 'C' 'D' '#' '*'];
letters_numbers =[ 10  11  12  13  14  15];

frequencies_array = [   0       1209    1336    1477    1633 ; 
                        697     1       2       3       10   ;
                        770     4       5       6       11   ;
                        852     7       8       9       12   ;
                        941     15      0       14      13  ];
  


%% generating sound wave in time and frequency
sound_t = [];
for key_num = 1:1:length(keys)
    
   
   key =  keys(key_num);
   
   key_letter_idex = find(letters == key); 
   
  if  length(key_letter_idex > 0 ) % letter
      
      key_letter_number = letters_numbers(key_letter_idex);
      
      [row,col] = find(frequencies_array == key_letter_number);
    
  else % number 
      
      [row,col] = find(frequencies_array == str2num(key));
    
  end
  
% keys_frequencies = [keys_frequencies; frequencies_array(1,col) frequencies_array(row,1)];
  
% frequencies of any key
frequencies = [frequencies_array(1,col) frequencies_array(row,1)] ;

% generating time variable
sampling_freq = 8000;
time_start = 0;
time_end = 1;
t =linspace(time_start,time_end,(time_end - time_start)*sampling_freq);

% generating sine wave of a certain key
sine_generated_t = 0.2*( sin(2*pi*frequencies(1)*t) + sin(2*pi*frequencies(2)*t) );

sound_t = [sound_t sine_generated_t];

end

%% playing sound and plotting
% playing the sound
sound(sound_t,sampling_freq)

% ploting the soundsampling_freq = 8000;
time_start = 0;
time_end = length(keys);
t_new =linspace(time_start,time_end,(time_end - time_start)*sampling_freq);
figure;
plot(t_new,sound_t);

% Frequency domain of the sound
f = linspace(-sampling_freq/2, sampling_freq/2, length(t_new));
sound_f = fftshift(fft(sound_t));
figure;
plot(f, sound_f);

%% receiver








