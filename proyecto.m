close all;
clear;
global PathTake,global Found;
SEErosion = strel('square',5);
SEDilata = strel('rectangle',[5 5]);



SEAErosion = strel('rectangle',[5 5]);
SEADilata = strel('rectangle',[5 5]);
%SEADilata = strel('rectangle',[4 4]);

im=imread('laberinto2.jpg');
imScalaNB=rgb2gray(im);
imTablero2 = imbinarize(imScalaNB,.3);


[filas, colum]=size(imScalaNB);

if filas>1000 || colum>1000
    im=imresize(im,.40);
end 
%im=imresize(im,.40);
figure(6),imshow(im);
imScalaNB=rgb2gray(im);
G= im(:,:,2);
B= im(:,:,3);
R= im(:,:,1);


imTablero = imbinarize(imScalaNB,.3);
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

imgAzulBN = rgb2gray(imgAzul-imgRoja);
im_filtAzul=imbinarize(imgAzulBN,.05);
im_filtAzul=imerode(im_filtAzul,SEAErosion);
im_filtAzul=imdilate(im_filtAzul,SEADilata);

centroideAzul = regionprops( im_filtAzul,'Centroid'); %buscando centroide del area azul

figure,imshow(im_filtAzul);
figure(1),imshow(imTablero+im_filtAzul+im_filtRojo);
imTablero2=imTablero+im_filtAzul+im_filtRojo;



RGB_Image = uint8( imTablero(:,:,[1 1 1]) * 255 );
im2 = rgb2gray(RGB_Image);
imTablero2=imcomplement(im2);
% busqueda(im2,centroideRojo.Centroid,centroideAzul.Centroid);

yE=round(centroideRojo.Centroid(:,1));
xE=round(centroideRojo.Centroid(:,2));

yS=round(centroideAzul.Centroid(:,1));
xS=round(centroideAzul.Centroid(:,2));

[PathTake,Found]=A_Star_Search(imTablero2,[xE yE],[xS yS]);

figure(4),imshow(im)

%# make sure the image doesn't disappear if we plot something else
hold on

 
 plot(fliplr((PathTake(:,2))'),fliplr((PathTake(:,1))'),'Color','r','LineWidth',2);
 
    set(gca,'XLim',[-1,size(imTablero2,2)+2],'YLim',[-1,size(imTablero2,1)+2]);
    set(gca,'YDir','reverse');
