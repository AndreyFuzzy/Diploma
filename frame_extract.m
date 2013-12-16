function bit = frame_extract(y,count,failsequence)
	nodesequence8 = [255:260];
	w = 0.0;
	
	yl = y(:,1);
	yr = y(:,2);
	Tl = wpdec(yl,8,'db8');
	Tr = wpdec(yr,8,'db8');	
	for i=1:1:3
		stripe = read(Tl,'cfs',nodesequence8(i));
		w = w + process_extract(stripe);
		stripe = read(Tr,'cfs',nodesequence8(i));
		w = w + process_extract(stripe);
	end
	
	if (w > 3)
			bit = 1;
		elseif (w < -3)
				bit = 0;
			else
				bit = 0;
	end
end