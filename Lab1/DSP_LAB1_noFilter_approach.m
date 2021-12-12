%%
clc
clear all
%% user input
% The User Will enter the number of keys
N_keys = input('Number of pressed keys: ');

while 1 

    % The user will enter the keys themselves
    keys = input('Enter the keys..\n','s');

    % to make sure that N_keys = length(keys)
     if length(keys)~= N_keys
         display('number of keys you entered is not correct, re-enter the keys ')
     else
         break
     end

end
     
%keys = "";
%while (length(keys) ~= N_keys) || (keys == "")
%    % The user will enter the keys themselves
%    keys = input('Enter the keys: ','s');
%end 


letters =        ['A' 'B' 'C' 'D' '#' '*'];
letters_mapping =[ 10  11  12  13  14  15];

num_freq_map =      [   0       1209    1336    1477    1633 ; 
                        697     1       2       3       10   ;
                        770     4       5       6       11   ;
                        852     7       8       9       12   ;
                        941     15      0       14      13  ];
  


%% generating sound wave in time and frequency
sound_t = [];

% generating time variable
sampling_freq = 8000;
time_start = 0;
time_end = 1;
t =linspace(time_start,time_end,(time_end - time_start)*sampling_freq);

for key_num = 1:1:N_keys
   
   key =  keys(key_num);
   
   key_letter_idex = find(letters == key); 
   
  if  key_letter_idex > 0  % letter
      
      key_letter_number = letters_mapping(key_letter_idex);
      
      [row,col] = find(num_freq_map == key_letter_number);
    
  else % number 
      
      [row,col] = find(num_freq_map == str2num(key));
    
  end

% frequencies of any key
keyToneFrequencies = [num_freq_map(1,col) num_freq_map(row,1)] ;

% generating sine wave of a certain key
sine_generated_t = 0.2*( sin(2*pi*keyToneFrequencies(1)*t) + sin(2*pi*keyToneFrequencies(2)*t) );

sound_t = [sound_t sine_generated_t];

end

%% playing sound and plotting
% playing the sound
sound(sound_t,sampling_freq)

% ploting the soundsampling_freq = 8000;
time_start = 0;
time_end = N_keys;
t_all =linspace(time_start,time_end,(time_end - time_start)*sampling_freq);

figure;
subplot(2,1,1)
plot(t_all,sound_t);
xlabel ( 'Time (sec)' )
ylabel ( 'Amplitude (V)' )
title  ( 'Sound in Time Domain' )


% Frequency domain of the sound
f = linspace(-sampling_freq/2, sampling_freq/2, length(t_all));
sound_f = fftshift(fft(sound_t));


subplot(2,1,2)
plot(f, abs(sound_f));
xlabel ( 'Frequency (Hz)' )
ylabel ( 'Amplitude (V)' )
title  ( 'Sound in Frequency Domain' )

%% receiver

std_frequencies = [ 697 770 852 941 1209 1336 1477 1633 ];

received_frequencies = zeros(N_keys, 2);

for n = 1:sampling_freq:N_keys*sampling_freq
    key_t = sound_t(n : n + sampling_freq - 1);
    key_f = abs(fft(key_t));
    
    i = 1;
    for freq = std_frequencies
       if(key_f(freq+1) > 200)
          received_frequencies( ceil(n/sampling_freq) , i) = freq;
          i = i + 1;
       end
    end
end

disp(received_frequencies);

%% extracting numbers

received_key = '';

for row = 1:N_keys
   freq1 = received_frequencies(row, 1); % the low freq  (first column)
   freq2 = received_frequencies(row, 2); % the high freq (first row)
   
   % deduce the number
   
   [row,col_1] = find(num_freq_map == freq1);
   [row_2,col] = find(num_freq_map == freq2);
   
   received_key_number = num_freq_map(row,col);
   
   
   if  received_key_number > 9  % letter
      
      key_letter_idex = find(letters_mapping == received_key_number);
      
      key = letters(key_letter_idex);
      
   else % number 
      
      key = num2str(received_key_number);
    
   end
   
   received_key = strcat(received_key,key);
   
end

received_key
