%LIMPIA LA PANTALLA Y TODAS LAS
%VARIABLES
clear all;
clc
%SELECCIONA IMAGEN Y LA CAMBIA A
%ESCALA DE GRISES
A=imread('laberinto_pdf.jpg');
figure(1)
imshow(A);
[d1,d2,d3] = size(A);
O=d1*d2;
if (d3>=3)
d=rgb2gray(A);
else
 d=(A);
end
% MUESTRA EL TAMAÑO DE LA IMAGEN Y
%CREA OTRAS DOS MATRICES DEL MISMO
% TAMAÑO
C=size(A);
B=zeros(d1,d2);
B2=zeros(d1,d2);
figure(2)
imshow(d);
whos
%HACE UN RECORTE DE LA IMAGEN
g=d1;
h=d2;
for i= 1:g
 for j=1:h
 m(i,j)=d(i,j);
 end
end

%CONVIERTE LA IMAGEN A BINARIO
A=0;
I=im2double(d);
for i=1:d1
 for j=1:d2
 A=A + I(i,j);
 end
end
media=A/O*.6;
J=im2double(m);
for i=1:g
 for j=1:h
 if J(i,j)< media
 J(i,j)=0;
 else
 J(i,j)=1;
 end
 end
end
figure (5)
imshow(J);
J=not(J);
imshow(J);[L Ne]=bwlabel(J);
%% CALCULAR LAS PROPIEDADES DE LOS
%OBJETOS DE LA IMAGEN
propied= regionprops(L);
hold on
%% BUSCAR AREAS MENORES
s=find([propied.Area]>20 & [propied.Area]<370);
%% MARCAR AREAS MENORES
for n=1:size(s,2)

rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','b','LineWidth',2)
end
%BUSCA LAS COORDENADAS DEL CENTROIDE
%DEL OBJETO
point=round(propied(s(1)).Centroid);
x=point(1);
y=point(2);
%% ELIMINAR AREAS MENORES
for n=1:size(s,2)

d=round(propied(s(n)).BoundingBox);

J(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
end
pause
j=1;
for i=1:size(s)
i;
 if i~0 ;
 v(j)=i;
 j=j+1;
 end
 end
v;
A=imread('laberinto_pdf.jpg');
imshow (A)
%SE BINARIZA LA IMAGEN
BA=im2bw(A,0.28);
q=size(BA);
figure(2)
imshow(BA);
figure(1)
imshow(BA);
%SE INVIERTE LA BINARIZACION
for i=1:q(1)
 for j=1:q(2)

 if BA(i,j) == 0;
 base(i,j)=1;
 base2(i,j)=1;
 end

 end
end
figure(2)
imshow(base);
figure(3)
imshow(base2);
%PONE UN PUNTO EN EL LABERINTO QUE
%SERVIRA PARA RESOLVERLO
for i=1:5
 for j=1:5

 base(i+x,j+y) = 1;

 end

end
figure(2)
imshow(base)
impixelinfo
rep =0;
cont1=0;
cont2=0;
close = point;
%CODIGO PARA RESOLVER EL LABERINTO
while cont1 ~= 1
%derecha
der=0;
%derecha
while der ~= 1

x=x+1;
if base2(y,x+5)== 1
 der =1;
end
for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%abajo
ab=0;
%abajo
while ab ~= 1


y=y+1;
if ((y+5) > 460)


 figure(3)
 imshow(base);
 cont2=1;
 cont1=1;
end


if base2(y+5,x)== 1
 ab =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%izquierda
izq=0;
%izquierda
while izq ~= 1

x=x-1;
if base2(y,x-5)== 1
 izq =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y-5,x)== 1
 arr =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;
 end

end
end
%izquierda
izq=0;
%izquierda
while izq ~= 1

x=x-1;
if base2(y,x-5)== 1
 izq =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;
 end

end
end
%abajo
ab=0;
%abajo
while ab ~= 1

 y=y+1;
if ((y+5) > 460)


 figure(3)
 imshow(base);
 cont2=1;
 cont1=1;
end
if base2(y+5,x)== 1
 ab =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
rep=rep+1;
if (x==close(1) && y==close(2))
 cont1=1;
end
if (rep >=35)
 cont1=1;
end
end
rep2=0;
close2 = point;
while cont2 ~= 1
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y-5,x)== 1
 arr =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%derecha
der=0;
%derecha
while der ~= 1

x=x+1;
if base2(y,x+5)== 1
 der =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;
 end

end
end
%abajo
ab=0;
%abajo
while ab ~= 1

y=y+1;
if ((y+5) > 460)


 figure(3)
 imshow(base);
 cont2=1;
 cont1=1;
end
if base2(y+5,x)== 1
 ab =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;
 end

end
end
%izquierda
izq=0;
%izquierda
while izq ~= 1

x=x-1;
if base2(y,x-5)== 1
 izq =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;
 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y-5,x)== 1
 arr =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%izquierda
izq=0;
%izquierda
while izq ~= 1

x=x-1;
if base2(y,x-5)== 1
 izq =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y-5,y)== 1
 arr =1;
end

for i=1:5
 for j=1:5
 base(i+y,j+x) = .80;

 end

end
end
%izquierda
izq=0;
%izquierda
while izq ~= 1

x=x-1;
if base2(y,x-5)== 1
 izq =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
%abajo
ab=0;
%abajo
while ab ~= 1

y=y+1;
if ((y+5) > 460)


 figure(3)
 imshow(base);

 cont2=1;
 break;
end
if base2(y+5,x)== 1
 ab =1;
end

for i=1:5
 for j=1:5

 base(i+y,j+x) = .80;

 end

end
end
rep2=rep2+1;
if (x==close2(1) && y==close2(2))
 cont2=1;

end
if (rep2 >=10)

 figure(3)
 imshow(base)
 cont2=1;
end
end
rep3 =0;
cont3=0;
cont4=0;
close = point;
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y-1,x)== 1 
arr =1;
end

for i=1:1
 for j=1:1
 base(i+y,j+x) = .80;

 end

end
end
%derecha
der=0;
%derecha
while der ~= 1

x=x+1;
if base2(y,x)== 1
 der =1;
end

for i=1:1
 for j=1:1

 base(i+y,j+x) = .80;

 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y,x)== 1
 arr =1;
end

for i=1:1
 for j=1:1
 base(i+y,j+x) = .80;
 end

end
end
%derecha
der=0;
%derecha
while der ~= 1

x=x+1;
if base2(y,x)== 1
 der =1;
end

for i=1:1
 for j=1:1

 base(i+y,j+x) = .80;

 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y,x)== 1
 arr =1;
end

for i=1:1
 for j=1:1
 base(i+y,j+x) = .80;

 end

end
end
%derecha
der=0;
%derecha
while der ~= 1

x=x+1;
if base2(y,x)== 1
 der =1;
end

for i=1:1
 for j=1:1

 base(i+y,j+x) = .80;

 end

end
end
%arriba
arr=0;
%arriba
while arr ~= 1

y=y-1;
if base2(y,x)== 1
 arr =1;
end

for i=1:1
 for j=1:1
 base(i+y,j+x) = .80;

 end

end
end
%derecha
der=0;
%derecha
while der ~= 1

y=x+1;

if base2(y,x)== 1
 der =1;
end

for i=1:1
 for j=1:1

 base(i+y,j+x) = .80;
 end

end
end
