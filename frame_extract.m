function bits = frame_extract(y)
	nodesequence8 = [255:260];
	w = [0.0,0.0,0.0];
	
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	Tr = wpdec(yr,8,'db8');	
	for i=1:1:6
		stripe = read(Tl,'cfs',nodesequence8(i));
		w(round(i/2)) = w(round(i/2)) + process_extract(stripe);
		stripe = read(Tr,'cfs',nodesequence8(i));
		w(round(i/2)) = w(round(i/2)) + process_extract(stripe);
	end
	
	for i=1:1:3
	if (w(i) > 1)
			bits(i) = 1;
		elseif (w(i) < -1)
				bits(i) = 0;
			else
				bits(i) = 2;
	end
end