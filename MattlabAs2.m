function Xw =  MyFT(Xt, t, w)
kr = 500;
pT= (2*pi)/wo;
a = zeros(1,kr);   %initializes an array for a with required size

% calculate a for different k values (this uses -50:50)
%for k = 1:1:kr 
   po = @(t) exp(-1j*(2*pi/pT)* t);
   sum = 0;
   %Integral approximation
   for k = 1:1:kr  %for t = 0.1:0.1:pT 
       presum = @(t) (Xt(t) .* po(t)); 
       sum = sum + 0.1*presum(t); 
   end
   a(k) = sum; 
end
% a repsesents the fourier coeffecents from k = -50:50   
Xw = a
end

function Xt =  MyiFT(Wt, w, t)

end
Xw = MyFT(Xt, t, w);
Xt = MyiFT(Wt, w, t);