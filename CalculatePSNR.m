

function PSNR = CalculatePSNR( IgI, reFrame) 
IgI = uint8(IgI);
reFrame =uint8(reFrame);


sum1=IgI-reFrame;
sum1=sum1.*sum1;
MSE=mean(mean(sum1));
PSNR=20*log10(255.0/(sqrt(MSE)));
% 
%     origImg = double(origImg); 
%     distImg = double(distImg); 
%     [M N] = size(origImg); 
%     error = origImg - distImg; 
%     MSE = sum(sum(error .* error)) / (M * N); 
%     if(MSE > 0) 
%         PSNR = 10*log(255*255/MSE) / log(10); 
%     else
%         PSNR = 99; 
%     end
end