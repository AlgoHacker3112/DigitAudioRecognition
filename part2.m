nfiles=dir('/MATLAB Drive/Digits_audio_file/Training/*.wav');
P='/MATLAB Drive/Digits_audio_file/Training/';
%ESD feature set for training dat
for i=1:400
    c=nfiles(i).name;
    pc=strcat(P,c);
    [y,Fs]=audioread(pc);
    dft_y=fft(y);
    if (mod(length(y),2)==0)
        dft_y=dft_y(1: length(y)/2);
    else
        dft_y=dft_y(1:((length(y)-1)/2)+1);
    end
    esd=abs(dft_y).^2;
    for k=1:1000
        Feature_set(i,k)=esd(k);
    end
end    

%k means
for k=1:10
    
    for i=1:1000
        average= sum(Feature_set((40*(k-1)+1):(40*(k)),i));
        k_means(k,i)=average/40;
    end
end

