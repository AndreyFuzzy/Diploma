function whole_insert(code,audiofile,audioout,L)
	Fs = 22050;
	samples = [1,Fs];
	signed = [];
	z = code.x;	
	for i=1:1:L
		[y,Fs] = audioread(audiofile,samples);
		samples = samples + Fs;
		y = frame_insert(y,z(:,i));
		signed = [signed; y];		
	end;
	[y,Fs] = audioread(audiofile);
	for i=1:1:length(signed)
		y(i,1) = signed(i,1);
		y(i,2) = signed(i,2);
	end;
	audiowrite(audioout,y,Fs);	
end