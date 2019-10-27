%% Load data to work with

load('smalldataset.mat');


% Signal to Noise ratio

%Finding Noise

noise_add = 0;
for i = 1:50
    for j = 1:50
        noise_add = noise_add + (smalldataset(i,j) - mean(smalldataset(:,j)))^2;
    end
end


noise = noise_add/(50*49);

%Finding signal

signal_add = 0;
for i =1:50
    signal_add = signal_add + mean(smalldataset(i,:))^2;
end

signal_add = signal_add/50;

signal = signal_add - noise/50;

snr_value = signal/noise;

%Euclidean Distance

inside = 0;

for i = 1:50
    for j =1:50
        inside = inside + (smalldataset(i,j) - mean(smalldataset(i)))^2;
    end
end

inside = sqrt(inside);

ed_value = inside/50;

fprintf('SNR Value is %2.2f' ,snr_value ,' Euclidean Distance is %2.2f \n' ,ed_value);
