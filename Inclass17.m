%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 

%pixel original
img1=imread('img1.tif');
img2=imread('img2.tif');

figure (2);
subplot(1,2,1); imshow(img1,[]);
subplot(1,2,2); imshow(img2,[]);
limg1=length(img1);

diffs=zeros(1,400); 
for ov=1:length(img1)-1 %if it is the same size it will crash
    %to get overlaping pixels
    pix1=img1(:,(end-ov):end);
    pix2=img2(:,1:(1+ov));
    %then the difference will be stored
    diffs(ov)=sum(sum(abs(pix1-pix2)))/ov;
end
figure (3); plot(diffs);

[~,overlap]=min(diffs);
img2align=[zeros(limg1,limg1-overlap-98),img2]; %won't let me shift x 

figure (4); imshowpair(img1,img2align);


%Fourier
img1ft=fft2(img1);
img2ft=fft2(img2);

[nr,nc]=size(img2ft); 
cc=ifft2(img1ft.*conj(img2ft));
ccabs=abs(cc);
figure (5); imshow(ccabs,[]); %image registration

[rows, cols]=find(ccabs==max(ccabs(:)));
%for relative not indeces
Nr=ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc=ifftshift(-fix(nc/2):ceil(nc/2)-1);
rows=Nr(rows);
cols=Nc(cols);

imgshift=zeros(nc+nc-ceil(2.2*cols),nr+nr-ceil(1.31*rows)); 
imgshift((end-(limg1-1)):end,(end-(limg1-1):end))=img2;

figure (6); imshowpair(img1,imgshift);




