function [x] = gdist(a,u)
    %[Y] = GDIST(A, X) Guitar Distortion
    %
    %   GDIST creates a distortion effect like that of
    %   an overdriven guitar amplifier. This is a Matlab 
    %   implementation of an algorithm that was found on 
    %   www.musicdsp.org.
    %
    %   A = The amount of distortion.  A
    %       should be chosen so that -1<A<1.
    %   X = Input.  Should be a column vector 
    %       between -1 and 1.
    %
    %coded by: Steve McGovern, date: 09.29.04
    %URL: http://www.steve-m.us

    x = (1+(2*a/(1-a))).*(u)./(1+(2.*a/(1-a)).*abs(u));
end