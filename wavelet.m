textfile = input('Textfile:');
fid = fopen(textfile, 'r');
bitmap = fread(fid, 'char=>uint32');
bitsequence = dec2bin(bitmap);
L = length(bitsequence);

outfid = fopen('E:\Diploma\out1.txt','w');

nodesequence8 = [255:260];
nodesequence7 = [130:134];
nodesequence6 = [67:69];
w = linspace(0.0,0.0,L*7);
failsequence = linspace(0,0,L*7);

audiofile = input('Audiofile:');
[sig,Fs] = audioread(audiofile);
samples = [1,Fs/4];

for count = 1:1:L
	[y,Fs] = audioread(audiofile,samples);
	y = y(:,1);
	samples = samples + Fs/4;
	T = wpdec(y,8,'db8');
	T1 = T;

	for i=1:1:6
		stripe = read(T,'cfs',nodesequence8(i));
		stripe = process_insert(stripe,mod(count,2));
		T1 = write(T1,'cfs',nodesequence8(i),stripe);
	end

	y = wprec(T1);

	T = wpdec(y,8,'db8');
	for i=1:1:6
		stripe = read(T,'cfs',nodesequence8(i));
		[wans, fail] = process_extract(stripe);
		w(count) = w(count) + wans;
		failsequence(count) = failsequence(count) + fail;		
	end
end

for i=1:1:L
	if (w(i)/(6 - failsequence(i)) > 0.5)
		bits(i) = 1;
	elseif(w(i)/(6 - failsequence(i)) < -0.5)
			bits(i) = 0;
		else
			bits(i) = 2;
	end
end

fclose(fid);
fclose(outfid);