figure('Menubar','None','Name','I Like Trains','NumberTitle','Off');
uicontrol('Style','PushButton','String','Insert','Position',[20,100,60,20],'Callback','whole_insert(code,audiofile,audioout,L);');
uicontrol('Style','PushButton','String','Extract','Position',[40,200,60,20],'Callback','x = whole_extract(audioout,L);');

textfile = input('Textfile:');
audiofile = input('Audiofile:');
audioout = input('Output file:');

fid = fopen(textfile, 'r');
bitmap = fread(fid, 'char=>uint32');
bitsequence = dec2bin(bitmap) - 48;
bitsequence = bitsequence';
L = length(bitsequence);

z = gf(bitsequence(:,1),1);
code = bchenc(z',15,7)';
for i=2:1:L
	z = gf(bitsequence(:,i),1);
	code = horzcat(code,bchenc(z',15,7)');
end;

whole_insert(code,audiofile,audioout,L);
whole_insert(code,audioout,audioout,L);
x = whole_extract(audioout,L);