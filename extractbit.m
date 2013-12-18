function [w] = extractbit(eL, eT, eR)
	alpha = 0.001;
	beta = 1;

	eM = (eL+eR)/2;
	L1 = (eT-eM)*alpha;
	L2 = (eT-eM)*beta;
	L3 = (L2-L1)/2;
	Re = abs(eL-eR)/2;
	if (Re <= L1)
		w = -1.0;
	elseif (Re >= L2)
			w = 1.0;
		else
			w = (Re-L1-L3)/L3;
	end
end