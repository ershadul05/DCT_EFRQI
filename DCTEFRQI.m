clc
close all;
clear all;
Im = imread('P_gray.jpg');
[row col]=size(Im);
Im1=Im(1:row,1:col);
Img2= Im1;
%Img1=im2double(Img2);
%Img2=round(Img1.*255);
%Img2=Im1(:,:,2);
[row1 col1]=size(Img2);
blocksize=8;
PSNR1=0;

BR=0;
Z=zeros(row1, col1);
Y=zeros(row1, col1);
for i=1:blocksize:row1
  for j=1:blocksize:col1

W1=Img2(i:i+blocksize-1,j:j+blocksize-1);

DCT=dct2(W1);

A(i:i+7,j:j+7)=DCT;

q=70;

B1q=round(DCT/q);
max(max(DCT));
absB1q= abs(B1q);
Max=max(max(absB1q));
MN=min(min(absB1q));


[x y z]=find(absB1q);
dectoBin=dec2bin(z,8);
dectoBina=uint16(dectoBin);
dectoBina=dectoBina-48;
numone=nnz(dectoBina);

rowb=dec2bin(x,log2(8));
urowb=uint16(rowb);
aurowb=urowb-48;
erowb=numel(aurowb);


colb=dec2bin(y,log2(8));
ucolb=uint16(colb);
aucolb=ucolb-48;
ecolb=numel(aucolb);
statebit=erowb+ecolb;
sbit=numel(z);


sbit=numel(z);

auxbit=numone;

tofolli=(2*statebit+2*sbit);

BR=BR+(numone+sbit+tofolli+auxbit)/(1024*1024);

B2=B1q.*q;

RI1=idct2(B2);

%figure 
%I1=imshow(RI1,[0, 255]);

Z(i:i+7,j:j+7)=RI1;
Y(i:i+7,j:j+7)=absB1q;

  end
end


%writematrix(absB1q, '70dearafterdct.csv');
PSNR1=CalculatePSNR(Img2, Z);

%tofolli=((log2(16)+log2(16)+1+1)*sbit)/(1000*1000);


numofblockr=row1/blocksize;
numofblockc=col1/blocksize;

rposioflastblock=row1-blocksize;
cposioflastblock=col1-blocksize;

numofcolbit=numel(dec2bin(rposioflastblock))-numel(dec2bin(blocksize));
numofrowbit=numel(dec2bin(cposioflastblock))-numel(dec2bin(blocksize));
tbitr=numofblockr*numofblockc*(numofcolbit+numofrowbit)/(1024*1024);

BR=BR+tbitr
bpp=(BR*1024*1024)/(row*col)

PSNR1