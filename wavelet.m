textfile = input('Textfile:');
fid = fopen(textfile, 'r');
bitmap = fread(fid, 'char=>uint32');
bitsequence = dec2bin(bitmap) - 48;
bitsequence = bitsequence';
L = length(bitsequence);

code = encode(bitsequence(:,1),15,11);
for i=2:1:L
	code = horzcat(code,encode(bitsequence(:,i),15,11));
end;

outfid = fopen('E:\Diploma\out1.txt','w');

nodesequence7 = [130:134];
nodesequence6 = [67:69];
w = linspace(0.0,0.0,L*7);
failsequence = linspace(0,0,L*7);

audiofile = input('Audiofile:');
[sig,Fs] = audioread(audiofile);
samples = [1,Fs];

for count = 1:1:L*3
	[y,Fs] = audioread(audiofile,samples);
	samples = samples + Fs;
	y = frame_insert(y,count,code(((count-1)*5+1):(count*5)));
	code(((count-1)*5+1):(count*5)) = frame_extract(y,count);
end

for i=1:1:L
	bits = decode(code(:,i),15,11);
	bits = bits(1:7);
	bitsequence(:,i) = bits;	
end;

bitsequence = bitsequence';
x = char(bin2dec(char(bitsequence+48)));
x = x';
fclose(fid);
fclose(outfid);