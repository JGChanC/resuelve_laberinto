function proyecto()
%
% Limpieza total antes de comenzar
%
close all hidden;
close all force;
clear;

fontSize=16;

%definir las variables globlales para pintar el camino e identificar si se
%encontro la solucion
global PathTake,global Found;

%filtros para la dilatacion y erosion para el tablero y la compoente roja
SEErosion = strel('square',8);
SEDilata = strel('rectangle',[8 8]);

%Filtros para la dilatacion y erosion para la componente azul
SEAErosion = strel('rectangle',[8 8]);
SEADilata = strel('rectangle',[8 8]);

continuar = true; %Opcion para identificar si el usuario desea proceder a
                  %seleccionar y comenzar el proceso de solucion del
                  %laberinto

cargoImagen = false;
limpioImagen = true;

MensajeBienvenida = sprintf('Bienvenido a nuestro programa que permite resolver un laberinto \naplicando procesamiento de imagenes e inteligencia artificial.\nPor favor seleccione una opción');
botonCacelar = questdlg(MensajeBienvenida, 'Mensaje', 'Continuar', 'Cancel', 'OK');
if strcmpi(botonCacelar, 'Cancel')
	continuar = false;
end

    while continuar
        
         while not(cargoImagen)
        
                [file path] = uigetfile({
                        '*.png;*.jpg;*.jpeg',...
                        'Imagenes'},...
                        'Seleccione el laberinto');
                if isequal(file,0)

                  MensajeErrorCargarFoto = sprintf('Seleccione una imagen');
                    botonMensaje = questdlg(MensajeErrorCargarFoto, 'Mensaje', 'Aceptar', 'Error');
                    if strcmpi(botonMensaje, 'Ok')
                        cargoImagen = false;
                    end

                else
                   cargoImagen = true;
                   disp(['User selected ', fullfile(path,file)]);
                end

         end
    
        % Cargando Imagen para guardarlo en una variable
        im=imread(fullfile(path,file)); 
        imScalaNB=rgb2gray(im); %Convertir la imagen a escala de grises
       
        %Imagen BN
        %figure(1),imshow(imScalaNB);
        
        [filas, colum]=size(imScalaNB); %Obtenemos las filas y columnas que
                                        %Conforman a la imagen
                                       
        %Si la imagen sobre pasa de las 1000 columnas se reduce su tamanio
        %a un 40%
               
        if filas>3000 || colum>3000
            im=imresize(im,.15);
            %Imagen Cambio de tamaño
            %figure(2),imshow(im);
        end 
        
        if filas>2000 || colum>2000
            im=imresize(im,.30);
            %Imagen Cambio de tamaño
            %figure(2),imshow(im);
        end 
        
        if filas>1000 || colum>1000
            disp("Entro aqui");
            im=imresize(im,.80);
            %Imagen Cambio de tamaño
            %figure(2),imshow(im);
        end 
       
        imScalaNB=rgb2gray(im);

        auxTablero = imbinarize(imScalaNB,.3);
         %Imagen Binaria
        % figure(3),imshow(auxTablero);
        
        box=regionprops(imcomplement(auxTablero),'Area', 'BoundingBox'); 
        imTablero = imcrop(auxTablero,box(1).BoundingBox);
        im=imcrop(im,box(1).BoundingBox);
        
        %figure(4),imshow(imTablero);
        
        subplot(2, 2, 1);
        imshow(im, []);
        title('Imagen Original', 'FontSize', fontSize);
        set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
        
        %Obteniendo las componentes de la imagen
        G= im(:,:,2); %Componente Verde
        B= im(:,:,3); %Componente Azul
        R= im(:,:,1); %Componente Roja
      

        %Erosionando el tablero y aplicando la dilatacion para limpiar 
        %el laberinto
       
        imTablero=imerode(imTablero,SEErosion);
        imTablero=imdilate(imTablero,SEDilata);
        
       

        imgRoja = im-G-B+R; %Restando de la imagen original las componentes G y B y aumentando la componente R
        imgAzul = im-G-R+B; %Restando de la imagen original las componentes G y R y aumentando la componente B

       subplot(2, 2, 2);
	   imshow(imgRoja-imgAzul, []);
	   title('Ubicando punto rojo', 'FontSize', fontSize);
       
       
       subplot(2, 2, 3);
	   imshow(imgAzul-imgRoja, []);
	   title('Ubicando punto azul', 'FontSize', fontSize);

            
        imgRojaBN = rgb2gray(imgRoja-imgAzul); %Restando a la imagen Roja la 
                                               %imagen azul esto para obtener solo el area que contenga Rojo
        
        
        im_filtRojo=imbinarize(imgRojaBN,.10); %Volvemos binaria la foto
        im_filtRojo=imerode(im_filtRojo,SEErosion); %Se le aplicamos la erosion
        im_filtRojo=imdilate(im_filtRojo,SEDilata); %Se le aplica la dilatacion

       
        
        centroideRojo = regionprops(im_filtRojo,'Centroid')%buscando centroide del area roja

        imgAzulBN = rgb2gray(imgAzul-imgRoja);%Restando a la imagen Azul la 
                                               %imagen Roja esto para
                                               %obtener solo el area que
                                               %contenga Azul
        
        im_filtAzul=imbinarize(imgAzulBN,.05); %Volvemos Binaria la imagen azul
        im_filtAzul=imerode(im_filtAzul,SEAErosion); %Se le aplica la erosion
        im_filtAzul=imdilate(im_filtAzul,SEADilata); %Se le aplica la dilatacion

        centroideAzul = regionprops( im_filtAzul,'Centroid') %buscando centroide del area azul

     
        imTablero2=imTablero+im_filtAzul+im_filtRojo; %Restando las imagenes 
                                                      %Roja y Azul al tablero
                                                      %para obtener el laberinto 
                                                      %limpio sin las marcas de
                                                      %busqueda

       subplot(2, 2, 4);
	   imshow(imTablero2, []);
	   title('Tablero limpio', 'FontSize', fontSize);
       
        %Creamos una negativa del tablero
        imTablero2=imcomplement(imTablero2);
        %figure(5),imshow(imTablero2);
        %figure(6),imshow(imTablero2);
     
        try

            %Ubicamos los puntos de Entrada y Salida
            
            %Punto Rojo (Inicio)
            yE=round(centroideRojo.Centroid(:,1));
            xE=round(centroideRojo.Centroid(:,2));

            %Punto Azul (Meta)
            yS=round(centroideAzul.Centroid(:,1));
            xS=round(centroideAzul.Centroid(:,2));
            limpioImagen = false;
        catch

            MensajeErrorLimpenziaFoto = sprintf('La imagen no cumple las características intente con otra.');
                    botonMensaje = questdlg(MensajeErrorLimpenziaFoto, 'Mensaje', 'Aceptar', 'Error');
                    if strcmpi(botonMensaje, 'Ok')
                        limpioImagen = true;
                    end
        end 
        
        if not(limpioImagen)
            
            [PathTake,Found]=A_Star_Search(imTablero2,[xE yE],[xS yS]);

            figure;  % Crear otra ventana, una nueva figura en la ventana.
            imshow(im);
            set(gcf, 'Position', get(0,'Screensize')); % Hacerla mas grande.
            title('Laberinto con solución', 'FontSize', fontSize);
            
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

        MensajeRepetir = sprintf('¿Desea resolver otro laberinto?');
        botonera = questdlg(MensajeRepetir, 'Mensaje', 'SI', 'NO', 'OK');
        if strcmpi(botonera, 'NO')
            continuar = false;
        elseif strcmpi(botonera,'SI')
            
            cargoImagen=false;
            close all hidden;
            close all force;
           
        end
    
    end


end