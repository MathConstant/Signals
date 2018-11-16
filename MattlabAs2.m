t = 1/16000;

Xw = MyFT(Xt, t, w);
Xt = MyiFT(Wt, w, t);

function Xw =  MyFT(Xt, t, w)	
	% t is time bettween samples 
	% Xt is an array 
	% w is fundemental frequency
	ak = fCoeff(Xt,wo,t)
	Xw = 2*pi .* ak
end

function Xt =  MyiFT(Wt, w, t)
	%t currently not used ether
	xt = @(t) 0*t;
	%sum 
	for k = 1:1:length(Wt) %not certain about how to make this an integral in terms of w
		ipo = @(t) exp(1j*(w)*t);
		xt = @(t) (xt(t) +  Wt(k)*ipo(t));
	end
	Xt = xt/(2*pi)
end


function ak = fCoeff(fun,wo,sT)
pT= (2*pi)/wo;
kr = length(fun)
a = zeros(1,kr);   %initializes an array for a with required size

for k = 1:1:kr 
   po = @(t) exp(-1j*(k - (kr/2 +1))*(2*pi/pT)* t);
   sum = 0;
   %Integral approximation
   for t = sT:sT:pT/sT
       presum = (fun(t* (1/sT)) * po(t))/pT; 
       sum = sum + sT*presum; 
   end
   a(k) = sum; 
end
ak = a
end