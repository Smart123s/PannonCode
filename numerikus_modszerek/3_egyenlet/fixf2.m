function [y] = fixf2(x)
    y = (exp(atan(x))-x^2)^2;
end