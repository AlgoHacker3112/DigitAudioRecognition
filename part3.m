[y1, Fs1] = audioread('/MATLAB Drive/Digits_audio_file/4digit.wav');
duration=floor(length(y1)/48); %milliseconds
%split into digits
c=0;
positions=0;
for i=1:duration
    means(i)=mean(abs(y1(48*i-47:48*i,1)));
    if means(i)<0.0001
        c=c+1;
        positions(c)=i;
    end
end 
s=0;
for i = 1:c-1
   if abs(positions(i+1)-positions(i))>2*48 % 2 msec
   s=s+1;
   splits(s)=positions(i+1);
   end
end
splits = splits.*48;
indi_digi(1,1:splits(1)) = y1(1:splits(1));
for i = 2:s
    indi_digi(i,1:splits(i)-splits(i-1))=y1(splits(i-1)+1:splits(i));
end
%clssify digits
for i=1:s
    dft_digi=fft(indi_digi);
    esd=abs(dft_digi).^2;
    esd=esd(1:1000);
    for k=1:10
        for j=1:1000
        check(k,j)=sqrt(((k_means(k,j)-esd(j))^2));
        end
        avg_check(k) = abs(mean(check(k,1:1000)));
    end
    min_avg=min(avg_check);
    index=0;
    for a=1:10
        if min_avg==avg_check(a)
            index=a ;
        end
    end
    prediction(i) = (index - 1);
end
prediction