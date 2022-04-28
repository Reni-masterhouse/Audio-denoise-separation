clear
close all

%绘制波形图
[x1, fs] = audioread('modulatedSong_noisy.wav');
x = x1(:, 1);
x = x';

%求取抽样点数
n1 = length(x); 

%显示实际时间
t1 = ((0: n1-1)/fs)'; 

%对信号进行傅里叶变换
y = fft(x, n1);

F = fs*(1: round(n1/2))/n1;
Y = y(1: round(n1/2));

%频域映射，转化为HZ
f = fs / n1 * (2: round(n1/2));

figure(1); 
subplot(2, 1, 1);
plot(t1, x, 'g');  %绘制时域波形
xlabel('时间/s'); 
ylabel('幅度');
title('原始信号的时域波形');
grid;

subplot(2, 1, 2);
plot(F(2: round(n1/2)), abs(Y(2: round(n1/2))), 'b');
xlabel('频率/Hz');
ylabel('幅度');
title('原始信号的幅频特性');
grid;

wn = [44e3/(fs/2), 46e3/(fs/2)];
b = fir1(48, wn, 'DC-0');
[h, w] = freqz(b, 1, round(n1/2));

figure(2)
subplot(2, 1, 1);
plot(w/pi, 20*log10(abs(h)));
title('带通滤波器幅频谱')
xlabel('频率/pi*rad');
ylabel('幅值/dB');

subplot(2, 1, 2);
plot(w/pi, angle(h));
title('带通滤波器相位谱')
xlabel('频率/pi*rad');
ylabel('相位/度');

%作用
hd = filter(b, 1, x1);

figure(3)
subplot(2, 1, 1);
plot(t1, hd, 'g');
xlabel('时间/s'); 
ylabel('幅度');
title('信号的波形');
grid;

hdfft = fft(hd);
subplot(2, 1, 2);
plot(F(1:round(n1/2)), abs(hdfft(1:round(n1/2))));
xlabel('频率/Hz');
ylabel('幅度');
title('滤波后幅度谱');
grid;

hd = hd.*cos(2*pi*45e3*t1);
%生成音频文件
audiowrite('45.wav', hd, fs);

wn = [64e3/(fs/2), 66e3/(fs/2)];
b = fir1(48, wn, 'DC-0');
[h, w] = freqz(b, 1, round(n1/2));

figure(4)
subplot(2, 1, 1);
plot(w/pi, 20*log10(abs(h)));
title('带通滤波器幅频谱')
xlabel('频率/pi*rad');
ylabel('幅值/dB');

subplot(2, 1, 2);
plot(w/pi, angle(h));
title('带通滤波器相位谱')
xlabel('频率/pi*rad');
ylabel('相位/度');

%作用
hd = filter(b, 1, x1);

figure(5)
subplot(2, 1, 1);
plot(t1, hd, 'g');
xlabel('时间/s'); 
ylabel('幅度');
title('信号的波形');
grid;

hdfft = fft(hd);

subplot(2, 1, 2);
plot(F(1:round(n1/2)), abs(hdfft(1:round(n1/2))));
xlabel('频率/Hz');
ylabel('幅度');
title('滤波后幅度谱');
grid;

hd = hd.*cos(2*pi*65e3*t1);
%生成音频文件
audiowrite('65.wav', hd, fs);