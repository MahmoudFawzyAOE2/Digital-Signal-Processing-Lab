function [amp_max, freq_amp_max] = filter_BPF( L, center_freq, sampling_freq, beta, key_t )

% the filter consists of series of impulses ( L impulses )
n = 0:1:L  ;

% filter equation in time domain
filter_t = beta * cos (2*pi* (center_freq/sampling_freq) * n);

% y(t)   =      x(t) (conv) h(t)
output_t = conv(key_t , filter_t , 'same');

% y(f) = F{ y(t) }
output_f = abs(fft(output_t));

% taking the maximum amplitude of the output 
% to indicate the presence of an input frequency
[amp_max, freq_amp_max] = max(output_f);

end

