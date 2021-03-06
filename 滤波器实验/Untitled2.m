[xn,fs] = audioread('SunshineSquare.wav');%读取音频

N = length(xn);
k = 0:N-1;
Xk = fft(xn);
subplot(2,2,1);plot(xn);grid on;title('原始音频时域图');ylabel('xn');
subplot(2,2,2);plot(fs*k/N,abs(Xk));grid on;title('原始音频频域图');ylabel('Xk');
%这里先运行一次找冲激对应的f
%滤波
yn = band(xn,0,fs);
yn = band(yn,1575,fs);
yn = band(yn,3150,fs);
yn = band(yn,4725,fs);
N1 = length(yn);
k1 = 0 : N1-1;
Yk = fft(yn);
subplot(2,2,3);plot(yn);grid on;title('滤波后音频时域图');ylabel('yn');
subplot(2,2,4);plot(fs*k1/N1,abs(Yk));grid on;title('滤波后音频频域图');ylabel('Yk');
%在运行试看效果
yn(85440:85455) = 0;
yn(118500:length(yn)) = 0;
%重新看效果
N2 = length(yn);
k2 = 0 : N2-1;
Yk = fft(yn);
subplot(2,2,3);plot(yn);grid on;title('滤波后音频时域图');ylabel('yn');
subplot(2,2,4);plot(fs*k2/N2,abs(Yk));grid on;title('滤波后音频频域图');ylabel('Yk');





function[y] = band(xn, f, fs)%带阻
w = 2*pi*f/fs; % w = ΩT
A = -2*cos(w);
hn = [1 A 1];
y = conv(xn, hn);
end