function bits = frame_extract(y,count,failsequence)
	nodesequence8 = [255:260];
	w = linspace(0.0,0.0,6);
	
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	Tr = wpdec(yr,8,'db8');	
	for i=1:1:5
		stripe = read(Tl,'cfs',nodesequence8(i));
		wans = process_extract(stripe);
		w(i) = w(i) + wans;
		stripe = read(Tr,'cfs',nodesequence8(i));
		wans = process_extract(stripe);
		w(i) = w(i) + wans;
		if (w(i) > 1)
			bits(i) = 1;
		elseif (w(i) < -1)
				bits(i) = 0;
			else
				bits(i) = 0;
		end
	end
end