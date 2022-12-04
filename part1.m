[y1, Fs1] = audioread('/MATLAB Drive/Digits_audio_file/Training/0_01_25.wav');

dft_y1=fft(y1);

if (mod(length(y1),2)==0)
    dft_y1=dft_y1(1: length(y1)/2);
else
    dft_y1=dft_y1(1:((length(y1)-1)/2)+1);
end
esd_1=abs(dft_y1).^2;
esd_1=esd_1(1:1000);


subplot(3,1,1)
plot(esd_1)
