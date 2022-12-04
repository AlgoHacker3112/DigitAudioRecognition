nfiles=dir('E:\GNU files\drive-download-20221026T043701Z-001\test-20221026T043638Z-001\test\*.wav');
P='E:\GNU files\drive-download-20221026T043701Z-001\test-20221026T043638Z-001\test\';
for i=1:100
    c=nfiles(i).name;
    pc=strcat(P,c);
    [y,Fs]=audioread(pc);
    N=0:length(y);
    freq=0:(Fs/length(y)):(Fs/2);
    dft_y=fft(y);
    if (mod(length(y),2)==0)
        dft_y=dft_y(1: length(y)/2);
    else
        dft_y=dft_y(1:((length(y)-1)/2)+1);
    end
    esd=abs(dft_y).^2;
    esd=esd(1:1000);
    for k=1:10
        for j=1:1000
        check(k,j)=((k_means(k,j)-esd(j))^2);
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
correct=0;
for k=1:10
    for i=10*(k-1)+1:10*k
    if (prediction(i)==k-1)
        correct=correct+1;
    end
    end
end
test_error=(100-correct)/100;
