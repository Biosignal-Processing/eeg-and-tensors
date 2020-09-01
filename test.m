%% Script to test cut.m function
% addpath ---> functions\cut.m

clearvars
close all
clc

%% Samples, Time and Frequency
Fs = 100;       % Sampling Frequency
T = 1/Fs;       % Sampling period
N = 2*Fs;       % Length of signal
t = (0:N-1)*T;  % Time vector

x(1,:) = sin(2*pi*t);
x(2,:) = sin(4*pi*t);

cutFrame = [0.33, pi/2];
tFrame = [cutFrame(1):T:cutFrame(2)];
y = cut(x, cutFrame, Fs);

figure
subplot(3,1,1)
plot(x')
subplot(3,1,2)
plot(t,x)
subplot(3,1,3)
plot(tFrame,y)
xticks([0:.2:2])
xlim([min(t) max(t)])
