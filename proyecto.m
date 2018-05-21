function proyecto()
close all hidden;
close all force;
clear;
global PathTake,global Found;
SEErosion = strel('square',6);
SEDilata = strel('rectangle',[8 8]);

%SEAErosion = strel('rectangle',[6 6]);
%SEADilata = strel('rectangle',[6 6]);
%SEADilata = strel('rectangle',[4 4]);
SEAErosion = strel('rectangle',[7 8]);
SEADilata = strel('rectangle',[18 8]);

[file path] = uigetfile({
    '*.png;*.jpg;*.jpeg',...
    'Imagenes'},...
    'Seleccione el laberinto');
if isequal(file,0)
  return;
else
   disp(['User selected ', fullfile(path,file)]);
end

im=imread(fullfile(path,file));

%im=imresize(im,0.4);

imScalaNB=rgb2gray(im);
%imTablero2 = imbinarize(imScalaNB,.3);


[filas, colum]=size(imScalaNB);

if filas>1000 || colum>1000
    im=imresize(im,.20);
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


figure(4),imshow(im_filtRojo);
centroideRojo = regionprops(im_filtRojo,'Centroid') %buscando centroide del area roja

imgAzulBN = rgb2gray(imgAzul-imgRoja);
im_filtAzul=imbinarize(imgAzulBN,.05);
im_filtAzul=imerode(im_filtAzul,SEAErosion);
im_filtAzul=imdilate(im_filtAzul,SEADilata);

centroideAzul = regionprops( im_filtAzul,'Centroid'); %buscando centroide del area azul

figure(5),imshow(im_filtAzul);
figure(1),imshow(imTablero+im_filtAzul+im_filtRojo);
imTablero2=imTablero+im_filtAzul+im_filtRojo;



RGB_Image = uint8( imTablero(:,:,[1 1 1]) * 255 );
im2 = rgb2gray(RGB_Image);
imTablero2=imcomplement(imTablero2);
% busqueda(im2,centroideRojo.Centroid,centroideAzul.Centroid);

yE=round(centroideRojo.Centroid(:,1));
xE=round(centroideRojo.Centroid(:,2));

yS=round(centroideAzul.Centroid(:,1));
xS=round(centroideAzul.Centroid(:,2));

disp("Punto de entrada:");
disp(xE);
disp(yE);
disp("---------------------");
disp("Punto de salida:");
disp(xS);
disp(yS);


[PathTake,Found]=A_Star_Search(imTablero2,[xE yE],[xS yS]);

figure(4),imshow(im)

%# make sure the image doesn't disappear if we plot something else
hold on

f = msgbox('Operación Completa','Mensaje','help');
if Found==1
    plot(fliplr((PathTake(:,2))'),fliplr((PathTake(:,1))'),'Color','r','LineWidth',2);
 
    set(gca,'XLim',[-1,size(imTablero2,2)+2],'YLim',[-1,size(imTablero2,1)+2]);
    set(gca,'YDir','reverse');
    
else 
    txt = 'No se encontró la solución';
    text(100,0,txt,'HorizontalAlignment','center','Color','red','FontSize',20)
    
end
end