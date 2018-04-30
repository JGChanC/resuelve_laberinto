close all;
clear;
im=imread('lab1.jpg');
figure,imshow(im);

G= im(:,:,2);
B= im(:,:,3);
R= im(:,:,1);
imgRoja = im-G-B+R;
imgAzul = im-G-R+B;

imgRojaBN = rgb2gray(imgRoja-imgAzul);
im_filt=imbinarize(imgRojaBN,.05);

imgAzulBN = rgb2gray(imgAzul-imgRoja);

figure,imshow(im_filt);
figure,imshow(imgAzulBN);
