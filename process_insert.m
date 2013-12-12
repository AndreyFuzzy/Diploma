function stripe = process_insert(stripe, bit)
	f = fft(stripe);
	g = abs(fft(stripe));
	if (isempty(findpeaks(g)) == 0)
		tone = max(findpeaks(g));
	else
		return;
	end
	indices = find(g==tone);
	if (length(indices) ~= 2)
		return;
	end
	if (indices(2) == length(stripe))
		return;
	end
	[y1,y2] = insertbit(g(indices(1)-1),g(indices(1)),g(indices(1)+1),bit);
	if ([y1,y2] == [g(indices(1)-1),g(indices(1)+1)])
		return;
	end
	f(indices(1)-1) = (cos(angle(f(indices(1)-1))) + sin(angle(f(indices(1)-1)))*sqrt(-1))*y1;
	f(indices(1)+1) = (cos(angle(f(indices(1)+1))) + sin(angle(f(indices(1)+1)))*sqrt(-1))*y2;
	f(indices(2)+1) = conj(f(indices(1)-1));
	f(indices(2)-1) = conj(f(indices(1)+1));
	stripe = ifft(f);
end