% these values would be passed for a) 
wo = 2*pi;
fun = @(t) 1 + cos(2*pi*t)/4 + cos(2*pi*2*t)/2 + cos(2*pi*t*3)/3;
kr = 100;


%a) 
function ak = fCoeff(fun,wo,kr)
pT= (2*pi)/wo;
a = zeros(1,kr);   %initializes an array for a with required size

% calculate a for different k values (this uses -50:50)
for k = 1:1:kr 
   po = @(t) exp(-1j*(k - (kr/2 +1))*(2*pi/pT)* t);
   sum = 0;
   %Integral approximation
   for t = 0.1:0.1:pT
       presum = @(t) (fun(t) .* po(t))/pT; 
       sum = sum + 0.1*presum(t); 
   end
   a(k) = sum; 
end
% a repsesents the fourier coeffecents from k = -50:50   
ak = a
end

a = fCoeff(fun,wo,kr)
% just to sanity check if it makes sense
figure, stem(a);

%b) would just need to pass [a]
%and [kr] (though that could be changed to just be size of a

function x = faSynth(a,wo)
xt = @(t) 0*t;
%sum 
for k = 1:1:length(a)
    ipo = @(t) exp(1j*(k - (length(a)/2 +1))*(wo)* t);
    xt = @(t) (xt(t) +  a(k)*ipo(t));
end
x = xt
end

xt = faSynth(a,wo)
% test: these should now be the same 
figure, stem(xt(t));
figure, plot(fun(t));