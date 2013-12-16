function frame = frame_insert(y,count,bit)
	nodesequence8 = [255:259];

	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	tl = Tl;
	Tr = wpdec(yr,8,'db8');
	tr = Tr;

	for i=1:1:3
		stripe = read(Tl,'cfs',nodesequence8(i));
		stripe = process_insert(stripe,bit);
		tl = write(tl,'cfs',nodesequence8(i),stripe);
		stripe = read(Tr,'cfs',nodesequence8(i));
		stripe = process_insert(stripe,bit);
		tr = write(tr,'cfs',nodesequence8(i),stripe);
	end

	yl = wprec(tl);
	yr = wprec(tr);
	frame = horzcat(yl,yr);
end