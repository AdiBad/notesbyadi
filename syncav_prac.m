%% Extract subset of data to work with

load('bigdataset.mat', 'EEGdata');

%{
smalldataset = zeros(50,50);
for i=1:50
    for j=1:50
     smalldataset(i,j) = EEGdata(i,j);
    end
end 
%}

%smalldataset(49);
%OR

smalldataset = EEGdata(1:50, 1:50);
%smalldataset(49)

%Remove baseline to account for impedence







%remove jitter using baseline
%baseline = mean(first ten columns)

for i = 1:50
    smalldataset(i) = smalldataset(i) - mean(smalldataset(1:10));
end

% template design = mean(every column)

template = zeros(1, 50);
for i = 1:50
    template(i) = mean(smalldataset(:,i));
end

%Plot the synchronized average
figure('name','Sync Av');
time = linspace(1/250, 50/250, 50);
plot(time,template);
ylabel('Amplitude');
xlabel('Time');

%Overlap the plot
figure('name','Overlapped');
for i = 1:50
    plot(time, smalldataset, 'g');
    hold on
end
plot(time, template, 'b');
ylabel('Amplitude');
xlabel('Time');
legend('Original','Template');

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







