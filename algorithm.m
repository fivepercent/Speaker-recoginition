
disp('EEL6825 Pattern Recognition');
disp('Speaker Recognition Using MFCC and Vector Quantization');
disp('Zhenle Zhu UFID: 64869907');
disp(' ');
[s1 fs1] = audioread('train_z\s1.wav');
[s2 fs2] = audioread('train_z\s2.wav');

%Plot of signal
disp('Plot of signal');
t = 0:1/fs1:(length(s1) - 1)/fs1;
plot(t, s1), axis([0, (length(s1) - 1)/fs1 -0.4 0.5]);
title('Plot of signal s1.wav');
xlabel('Time [s]');
ylabel('Amplitude (normalized)')

pause
close all

%linear spectrum plot
disp('linear spectrum plot');
M = 100;
N = 512;
frames = FrameBlocking(s1, fs1, M, N);
t = N / 2;
tm = length(s1) / fs1;
subplot(121);
imagesc([0 tm], [0 fs1/2], abs(frames(1:t, :)).^2), axis xy;
title('Linear (M = 100, N = 512)');
xlabel('Time [s]');
ylabel('Frequency [Hz]');
colorbar;

%logarithmic spectrum plot
disp('logarithmic spectrum plot');
subplot(122);
imagesc([0 tm], [0 fs1/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
title('Logarithmic (M = 100, N = 512)');
xlabel('Time [s]');
ylabel('Frequency [Hz]');
colorbar;
D=get(gcf,'Position');
set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*2.5 D(4)*1.3]))

pause
close all

%Plots for different values for N
disp('Plots for different values for N');
lN = [256 512 1024];
u=220;
for i = 1:length(lN)
    N = lN(i);
    M = round(N / 3);
    frames = FrameBlocking(s1, fs1, M, N);
    t = N / 2;
    temp = size(frames);
    nbframes = temp(2);
    u=u+1;
    subplot(u)
    imagesc([0 tm], [0 fs1/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
    title(sprintf('Power Spectrum (N = %i)',N));
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    colorbar
end
D=get(gcf,'Position');
set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*2 D(4)*1.5]))
pause
close all

%Mel-Spaced Filterbank
disp('Mel Space');
plot(linspace(0, (fs1/2), 129), (melfilterbank(20, 256, fs1))');
title('Mel-Spaced Filterbank');
xlabel('Frequency [Hz]');

pause
close all

%2D plot of accustic vectors
disp('2D plot of acoustic vectors');
c1 = mfcc(s1, fs1);
c2 = mfcc(s2, fs2);
plot(c1(5, :), c1(6, :), 'or');
hold on;
plot(c2(5, :), c2(6, :), 'xb');
xlabel('5th Dimension');
ylabel('6th Dimension');
legend('Signal 1', 'Signal 2');
title('2D plot of acoustic vectors');

pause
close all

%Plot of the 2D trained VQ codewords
disp('Plot of the 2D trained VQ codewords')
d1 = vqlbg(c1,16);
d2 = vqlbg(c2,16);
plot(c1(5, :), c1(6, :), 'xr')
hold on
plot(d1(5, :), d1(6, :), 'vk')
plot(c2(5, :), c2(6, :), 'xb')
plot(d2(5, :), d2(6, :), '+k')
xlabel('5th Dimension');
ylabel('6th Dimension');
legend('Speaker 1', 'Codebook 1', 'Speaker 2', 'Codebook 2');
title('2D plot of acoustic vectors');
pause
close all