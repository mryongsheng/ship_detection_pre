function dataVariance = getLocalVariance(srcData, nHeight, nWidth, r)
% ����ֲ�����
N               = boxfilter(ones(nHeight, nWidth), r);
srcDataMean     = boxfilter(srcData, r) ./ N;
srcDataDataMean = boxfilter(srcData.*srcData, r) ./ N;
dataVariance    = srcDataDataMean - srcDataMean .* srcDataMean;
end
