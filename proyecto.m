close all;
clear;
SEErosion = strel('square',30);
SEDilata = strel('square',30);
im=imread('lab1.jpg');
figure,imshow(im);

G= im(:,:,2);
B= im(:,:,3);
R= im(:,:,1);

imTablero = imbinarize(rgb2gray(im),.3);
imTablero=imerode(imTablero,SEErosion);
imTablero=imdilate(imTablero,SEDilata);



imgRoja = im-G-B+R;
imgAzul = im-G-R+B;

imgRojaBN = rgb2gray(imgRoja-imgAzul);
im_filtRojo=imbinarize(imgRojaBN,.10);
im_filtRojo=imerode(im_filtRojo,SEErosion);
im_filtRojo=imdilate(im_filtRojo,SEDilata);
figure,imshow(im_filtRojo);
centroideRojo = regionprops(im_filtRojo,'Centroid') %buscando centroide del area roja
disp(centroideRojo);

imgAzulBN = rgb2gray(imgAzul-imgRoja);
im_filtAzul=imbinarize(imgAzulBN,.05);
im_filtAzul=imerode(im_filtAzul,SEErosion);
im_filtAzul=imdilate(im_filtAzul,SEDilata);
centroideAzul = regionprops( im_filtAzul,'Centroid') %buscando centroide del area roja
disp(centroideAzul);
figure,imshow(im_filtAzul);
figure,imshow(imTablero+im_filtAzul+im_filtRojo);

disp(centroideRojo);
disp(centroideAzul);
im2 =cat(3,imTablero,imTablero,imTablero);
%busqueda(rgb2gray(im2),[127 186],[218 251]);

