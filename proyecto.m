close all;
clear;
im=imread('laberintp.jpg');
figure,imshow(im);

G= im(:,:,2);
B= im(:,:,3);
R= im(:,:,1);
imgRoja = im-G-B;
imgAzul = im-G-R;

imgRojaBN = rgb2gray(imgRoja);
imgAzulBN = rgb2gray(imgAzul);

figure,imshow(imgRojaBN);
figure,imshow(imgAzulBN);


