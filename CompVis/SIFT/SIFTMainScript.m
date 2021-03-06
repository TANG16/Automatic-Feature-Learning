function [tp fp] = SIFTMainScript(posdesc, negdesc, testpos, testneg)
matlabpool(4);
totalcou = 0;
matchcou = 0;
finfo = dir(testpos);
n = size(finfo, 1);
result = zeros(n, 1);
parfor i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([testpos '\' finfo(i).name]);
            [temp desc] = sift(img);
            mpos = match(posdesc, desc);
            mneg = match(negdesc, desc);
            result(i) = (mpos > mneg);
        catch
        end
    end
    display(i);
end
for i = 1:n
    if(~finfo(i).isdir)
        try
            img = imread([testpos '\' finfo(i).name]);
            totalcou = totalcou + 1;
        catch
        end
    end
end
tp = sum(result) / totalcou;

totalcou = 0;
matchcou = 0;
result = zeros(1000, 1);
finfo = dir(testneg);
n = size(finfo, 1);
parfor i = 1:1000
    if(~finfo(i).isdir)
        try
            img = imread([testneg '\' finfo(i).name]);
            [temp desc] = sift(img);
            mpos = match(posdesc, desc);
            mneg = match(negdesc, desc);
            result(i) = (mpos > mneg);
        catch
        end
    end
    display(i);
end
for i = 1:1000
    if(~finfo(i).isdir)
        try
            img = imread([testpos '\' finfo(i).name]);
            totalcou = totalcou + 1;
        catch
        end
    end
end
fp = sum(result) / totalcou;

return;