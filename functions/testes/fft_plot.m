function [y, y_dc, y_pca] = pre_processing(x,fs,varargin)
%% Applies a pre processing method
% [y] = pre_processing(x, 'norm', norm) 
%         returns a matrix centralized and scaled. The y matrix is the x, 
%         but with zero mean and one of standart deviation.
%
% [...] = pre_processing(x, 'notch', notch) 
%         returns a matrix filtered with a Butterworth notch filter 2nd 
%         order. The width of the notch is defined by the 59 to 61 Hz 
%         frequency interval. The filter removes at least half the power 
%         of the frequency components lying in that range.         
%         The y matrix is the x, but filtered in 60 Hz.
%
%% Example 1
% [y] = pre_processing(x, fs, 'norm');
%
%% Example 2
% [y] = pre_processing(x, fs, 'norm', 'notch');
% 
%% Example 3
% [y] = pre_processing(x, fs, 'norm', 'notch', 'plot');
% 

%% Conditions
if nargin > 5
    error('pre_processing: Too many input arguments.');
end

if ~nargin
    error('pre_processing: Requires at least one input argument.');
end

%% Center and Scalling
% Measure Standart Deviation
x_std=std(x);
% Measure the mean
x_mean=mean(x);
% Take the number os channels
n = size(x,2);
% Matriz with zeros, same size of x's matrix
y_dc=x.*0;
% Center and scale each 'ii' channel 
for ii=1:n
	y_dc(:,ii)=(x(:,ii) - x_mean(ii));
end

y_pca=y_dc/x_std;
% VARIABLES TO RETURN FROM THIS PART
% y_c & y_pca

%% Filter
if nargin >= 4
    % Filter Design
    d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',fs);
    % SIGNAL FILTERING - Pre allocating size for y_K
    filtrado=y_dc*0;
    
    % Filtering each 'ii' channel 
    for ii=1:n
        filtrado(:,ii) = filtfilt(d,y_dc(:,ii));
    end
    
    if nargin == 5
        % Time axis
        ts=1/fs;    
        t=0:ts:(size(x,1)-1)*ts;

        % Normalized x Filtered plot
        figure; 
        plot(t,y_dc(:,1))
%         xlabel('Tempo (s)');
%         ylabel('Amplitude (\muV)');
%         legend('Normalized');
%         grid
%         figure;
        hold on % Comment
        plot(t,filtrado(:,1));
        xlabel('Tempo (s)');
        ylabel('Amplitude (\muV)');
        legend('Norm'); % Comment
        legend('Norm','Normalized and Filtered');
        grid
        hold off % Comment
        % Mag Filtering Plot
        fvtool(d,'Fs',fs)
    end
    y=filtrado;
end

%% Clean useless variables
clearvars -except y y_dc y_pca
end

