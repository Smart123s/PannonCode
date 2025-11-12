function [y] = fixf3(x)
    y = sqrt(exp(atan(x))-sqrt(x));
end