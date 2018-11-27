function Xt =  MyiFT(Wt, w, ts)
	xt = @(t) 0*t;
	% integral aproximation with the dist between w points being 1
	for k = 1:1:length(w) 
		ipo = @(t) exp(1j* w(k)*t);
		xt = @(t) xt(t) + Wt(k)*ipo(t);
    end	
	xt = @(t) xt(t)/(2*pi);
	% just so that this returns an array as to use the passed ts
	Xt = xt(ts) 
end