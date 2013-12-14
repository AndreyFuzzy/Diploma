function w = process_extract(stripe)
	f = abs(fft(stripe));
	if (isempty(findpeaks(f)) == 0)
		tone = max(findpeaks(f));
	else
		w = 0.0;
		return
	end
	indices = find(f==tone);
	if (length(indices) ~= 2)
		w = 0.0;
		return
	end
	if (indices(2) == length(stripe))
		w =0.0;
		return;
	end
	w = extractbit(f(indices(1)-1),f(indices(1)),f(indices(1)+1));
end