function [eL,eR] = insertbit(eL, eT, eR, bit)
	alpha = 0.1;
	beta = 0.5;

	eM = (eL+eR)/2;
	L1 = (eT-eM)*alpha;
	L2 = (eT-eM)*beta;
	Re = abs(eL-eR)/2;
	if (bit == 0)
		if (Re > L1)
			if (eL >= eR)
				eL = eM + L1;
				eR = eM - L1;
			else
				eL = eM - L1;
				eR = eM + L1;
			end
		end
	end
	if (bit == 1)
		if(Re < L2)
			if (eL >= eR)
				eL = eM + L2;
				eR = eM - L2;
			else
				eL = eM - L2;
				eR = eM + L2;
			end
		end
    end
end