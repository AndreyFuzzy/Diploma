filename = 'D:\Diploma\2.wav';
wavename = 'db8';
bitsequence = [1,0,1,1,0,1,1,1,1,1];
failsequence = [0,0,0,0,0,0,0,0,0,0];
nodesequence = [255:265];
w = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
threshold = 0.5;

[sig,Fs] = audioread(filename);
samples = [1,Fs/2];
counter = 0;

for count = 1:1:floor(length(sig)/Fs*2)
	[y,Fs] = audioread(filename,samples);
	y = y(:,1);
	counter = counter + 1;
	samples = samples + Fs/2;
	T = wpdec(y,8,wavename);
	T1 = T;

	for i=1:1:6
		stripe = read(T,'cfs',nodesequence(i));
		stripe = process_insert(stripe,bitsequence(i));
		T1 = write(T1,'cfs',nodesequence(i),stripe);
	end

	y = wprec(T1);

	for i = 1:1:Fs/2
		signedsignal((counter-1)*Fs/2+i) = y(i);
	end
end

counter = 0;

for count = 1:1:floor(length(sig)/Fs*2)
	for j = 1:1:Fs/2
		y(j) = signedsignal(counter*Fs/2+j);
	end
	counter = counter + 1;

	T = wpdec(y,8,wavename);
	for i=1:1:6
		stripe = read(T,'cfs',nodesequence(i));
		[wans, fail] = process_extract(stripe);
		w(i) = w(i) + wans;
		failsequence(i) = failsequence(i) + fail;		
	end	
end

for i=1:1:6
	if (w(i)/(floor(length(sig)/Fs*2)-failsequence(i)) > threshold)
		bits(i) = 1;
	elseif(w(i)/(floor(length(sig)/Fs*2)-failsequence(i)) < -threshold)
			bits(i) = 0;
		else
			bits(i) = 2;
	end
end