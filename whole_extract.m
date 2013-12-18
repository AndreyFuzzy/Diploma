function x = whole_extract(audioout,L)
	Fs = 22050;
	samples = [1,Fs];
	x = '';
	for i=1:1:L
		[y,Fs] = audioread(audioout,samples);
		samples = samples + Fs;
		code(:,i) = frame_extract(y);
		code = gf(code,1);
	end
	for i=1:1:L
		bits = bchdec(code(:,i)',15,7)';
		x = [x,char(bin2dec(char(bits.x+48)'))];
	end;
end