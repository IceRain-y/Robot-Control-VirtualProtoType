%符号函数
function y=sgn(x)
    if x>0
        y=1;
    elseif x<0;
        y=-1;
    else 
        y=0;
    end
end