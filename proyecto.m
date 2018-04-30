close all;
clear;
%solve_maze('laberintp.jpg');
SEErosion = strel('square',8);
SEDilata = strel('square',8);

im=imread('lab1.jpg');

im=imresize(im,.25);
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

centroideAzul = regionprops( im_filtAzul,'Centroid') %buscando centroide del area azul
figure,imshow(im_filtAzul);
figure,imshow(imTablero+im_filtAzul+im_filtRojo);

RGB_Image = uint8( imTablero(:,:,[1 1 1]) * 255 );
im2 = rgb2gray(RGB_Image);
busqueda(im2,centroideRojo.Centroid,centroideAzul.Centroid);

