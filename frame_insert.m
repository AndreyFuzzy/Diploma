function y = frame_insert(y,bits)
	nodesequence8 = [255:261];
	nodesequence7 = [130:134];
	nodesequence6 = [67:70];

	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	tl = Tl;
	Tr = wpdec(yr,8,'db8');
	tr = Tr;

	for i=1:1:6
		stripe = read(Tl,'cfs',nodesequence8(i));
		stripe = process_insert(stripe,bits(i));
		tl = write(tl,'cfs',nodesequence8(i),stripe);
		stripe = read(Tr,'cfs',nodesequence8(i));
		stripe = process_insert(stripe,bits(i));
		tr = write(tr,'cfs',nodesequence8(i),stripe);
	end

	yl = wprec(tl);
	yr = wprec(tr);
	y = horzcat(yl,yr);
	
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,7,'db8');
	tl = Tl;
	Tr = wpdec(yr,7,'db8');
	tr = Tr;

	for i=1:1:5
		stripe = read(Tl,'cfs',nodesequence7(i));
		stripe = process_insert(stripe,bits(i+6));
		tl = write(tl,'cfs',nodesequence7(i),stripe);
		stripe = read(Tr,'cfs',nodesequence7(i));
		stripe = process_insert(stripe,bits(i+6));
		tr = write(tr,'cfs',nodesequence7(i),stripe);
	end
	
	yl = wprec(tl);
	yr = wprec(tr);
	y = horzcat(yl,yr);
	
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,6,'db8');
	tl = Tl;
	Tr = wpdec(yr,6,'db8');
	tr = Tr;

	for i=1:1:4
		stripe = read(Tl,'cfs',nodesequence6(i));
		stripe = process_insert(stripe,bits(i+11));
		tl = write(tl,'cfs',nodesequence6(i),stripe);
		stripe = read(Tr,'cfs',nodesequence6(i));
		stripe = process_insert(stripe,bits(i+11));
		tr = write(tr,'cfs',nodesequence6(i),stripe);
	end
	
	yl = wprec(tl);
	yr = wprec(tr);
	y = horzcat(yl,yr);
end