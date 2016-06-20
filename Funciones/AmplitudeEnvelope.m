function feature_rms = AmplitudeEnvelope(in, hop, wLen)
if (~exist('in'))
    error('AmplitudeEnvelope(in, ...): "in" es un parametro requeridos')
end

if (~exist('hop'))
    hop = 256;
end
if (~exist('wLen'))
    wLen = 1024;
end

in = in(:,1);
w = hanning(wLen);
normW = norm(w,2);
pft = 1;
lf = floor((length(in) - wLen)/hop);
feature_rms = zeros(lf,1);
tic

pin = 0;
pend = length(in) - wLen;

while pin<pend
    grain = in(pin+1:pin+wLen).*w;
    feature_rms(pft) = norm(grain,2)/normW;
    pft = pft+1;
    pin = pin+hop;
end

toc
%subplot(2,2,1); plot(in); axis([1 pend -1 1])
%subplot(2,2,2); plot(feature_rms); axis([1 lf -1 1])
end