function c = Conv(signal1, signal2)
	% signal1 will be kept stationary, signal2 shifted
	lower_bound = 1;
	upper_bound = length(signal1) + length(signal2);

	% Fill 0s to accomodate shifting beyond bounds of signal1
	zeros_fill = zeros(1, upper_bound - length(signal2));
	signal2 = [signal2, zeros_fill];

	result = zeros(1, length(signal1));
	% shift signal2 across 1:
	for t = lower_bound:upper_bound
		% Each iteration is a 'frame' of s2 superimposed over s1.
		
		sum = 0;
		% take sum of products for a frame:
		for k = max(t - length(signal2), 1):min(t, length(signal1))
			sum = sum + signal1(k) * signal2(max(t - k, 1));
		end
		result(t) = sum;
	end
end

sig1 = ones(1, 100);
sig2 = 0.01:0.01:2;

result = conv(sig1, sig2)
figure, plot(result)
