function Xt =  MyiFT(Wt, w)
	xt = @(t) 0*t;
	for k = 1:1:length(w) 
		ipo = @(t) exp(1j* w(k)*t);
		xt = @(t) xt(t) + Wt(k)*ipo(t);
    end	
	Xt = @(t) xt(t)/(2*pi);
end