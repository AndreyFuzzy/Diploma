function bits = frame_extract(y)
	nodesequence8 = [255:260];
	nodesequence7 = [130:134];
	nodesequence6 = [67:70];
		
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	Tr = wpdec(yr,8,'db8');	
	for i=1:1:6
		stripe = read(Tl,'cfs',nodesequence8(i));
		w(i) = process_extract(stripe);
		stripe = read(Tr,'cfs',nodesequence8(i));
		w(i) = w(i) + process_extract(stripe);
	end
	
	Tl = wpdec(yl,7,'db8');
	Tr = wpdec(yr,7,'db8');	
	for i=1:1:5
		stripe = read(Tl,'cfs',nodesequence7(i));
		w(i+6) = process_extract(stripe);
		stripe = read(Tr,'cfs',nodesequence7(i));
		w(i+6) = w(i+6) + process_extract(stripe);
	end
	
	Tl = wpdec(yl,6,'db8');
	Tr = wpdec(yr,6,'db8');
	
	for i=1:1:4
		stripe = read(Tl,'cfs',nodesequence6(i));
		w(i+11) = process_extract(stripe);
		stripe = read(Tr,'cfs',nodesequence6(i));
		w(i+11) = w(i+11) + process_extract(stripe);
	end
	
	for i=1:1:15
	if (w(i) < -1)
		bits(i) = 0;
	else
		bits(i) = 1;	
	end
end