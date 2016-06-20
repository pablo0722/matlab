function [y] = phaser(filename)
%[y] = phaser(filename)
%
%   This is a basic flanging effect.
%
%      fs = Sample rate
%      v = Variation.
%      x = Input audio signal. This should be a column 
%          vector.
%      r = Rate.
%
%   Example:
%     
%      >>y = flange(fs,0.002,x,0.5);
%
%
%   See also WAVREAD and SOUND
%
%Version 1.0
%Coded by: Stephen G. McGovern, date: 08.03.03

[in, fs] = wavread(filename);   % Cargo audio
in = in(:,1);                   % Tomo un solo canal
in_orig = in;                   % Guardo señal original

md= ceil(v*fs);
n=1:length(y)+md;
v=round(v*fs);
z=zeros(md,1);
m=max(abs(y));
y=[z;y;z];
rr=2*pi/round(fs*r);
b=round((v/2)*(1-cos(rr.*n)));
y=y(n+md)+y(n+md-b);
m=m/max(abs(y));
y=m*y;
end