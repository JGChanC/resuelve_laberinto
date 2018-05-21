
function [CaminoEncontrado, SeEncontro]=A_Star_Search(laberinto,inicio,meta)
tic; %Iniciamos el cronomero para medir el rendimiento de busqueda
costo=1; %Costo Inicial 
SeEncontro=false; %Bandera que indica si se encontro el camino
Resigno=false; %Bandera que indica que se resigno la busqueda
contatiempo=0; %timer del progress bar

global BarraDeCarga; %Creacion de la variable del progress bar
BarraDeCarga = waitbar(contatiempo,'Por favor espere...'); %Creacion del objeto y mensaje de barra de carga


Heuristica=CalculaHeuristica(laberinto,meta); %Calcula la Heuristica   
ExpansionGrid(1:size(laberinto,1),1:size(laberinto,2)) = -1; %Visualizar el camino expandido
AccionesTomadas=zeros(size(laberinto)); %Matriz donde se guarda las acciones que se toman to reach that particular cell
CaminoOptimo(1:size(laberinto,1),1:size(laberinto,2))={' '}; %Camino optimo basado en el A estrella

%Como se puede mover dentro del laberinto

movimientos = [-1,  0; % Ir Arriba
          0, -1; % Ir a la izquierda
          1,  0; % Ir Abajo
          0,  1; % Ir a Derecha
          1,  1; %Ir Diagonal Abajo
         -1, -1];%Ir Diagonal up

contatiempo=.20;
waitbar(contatiempo,BarraDeCarga,'Calculando Heuristica Del Laberinto');

 %Recorriendo el laberinto
 for i=1:size(laberinto,1) %Recorriendo el laberinto por filas
     for j=1:size(laberinto,2) %Recorriendo el laberinto por columnas
         celdaDelLaberinto=Buscar(); %iniciando el obj de la celda
         if(laberinto(i,j)>0) %Si el valor de la coordenada del laberito es blanco
            celdaDelLaberinto=celdaDelLaberinto.Set(i,j,1,Heuristica(i,j)); %Se setea el valor de la celda del laberinto 
         else %Si no
             celdaDelLaberinto=celdaDelLaberinto.Set(i,j,0,Heuristica(i,j)); %Se setea el valor de 0 a la celda del laberinto
         end
         GRID(i,j)=celdaDelLaberinto; %Guardar la celda del laberinto en el GRID auxliar
         clear gridCell; %Eliminar objeto creado
     end
 end
 
%Cambiando mensaje de barra de carga
    contatiempo=.33;
    waitbar(contatiempo,BarraDeCarga,'Buscando Camino');
%------------------------------------------------------

%Objeto Inicio
    ObjInicio=Buscar(); %Crear objeto del inicio del laberinto
    %Setenado los valores del punto de inicio y agregando su heuristica
    ObjInicio=ObjInicio.Set(inicio(1),inicio(2),laberinto(inicio(1),inicio(2)),Heuristica(inicio(1),inicio(2)));
    ObjInicio.isChecked=1; %Marcando el nodo como visitado
    GRID(ObjInicio.coorX,ObjInicio.coorY).isChecked=1; %Marcar la casilla del Grid auxialiar como visitado
%------------------------------------------------------------------------------------------

%Objeto Meta
ObjMeta=Buscar(); %Crear el objeto del nodo de la meta 
ObjMeta=ObjMeta.Set(meta(1),meta(2),laberinto(meta(1),meta(2)),0); %Setear los valores del nodo
%-----------------------------------------------------------------------------------------------

ListaAbierta=[ObjInicio]; %anexando el punto de inicio a la lista abierta
ExpansionGrid(ObjInicio.coorX,ObjInicio.coorY)=0; %Agregar el valor 0 al punto inicio

costo_menor=ObjInicio.gValue+ObjInicio.hValue; %Sacar el valor del costo minimo
 
contador=0; %iniciamos cotador
contatiempo=.53; %Cambiar el valor progress bar

while(SeEncontro==false || Resigno==false) %Repetir hasta que no se encuentre el camino o se resigne la busqueda
    
  waitbar(contatiempo,BarraDeCarga,'Buscando Camino.');
    
 costo_menor=ListaAbierta(1).gValue+ListaAbierta(1).hValue+costo; %Calculando costo del elemento de la lista abierta
 
    for i=1:size(ListaAbierta,2)
        fValue=ListaAbierta(i).gValue+ListaAbierta(i).hValue;
        if(fValue<=costo_menor)
            costo_menor=fValue;
            NodoExpandido=ListaAbierta(i);
            ApuntadorListaAbierta=i;
        end
    end
    
   
    ListaAbierta(ApuntadorListaAbierta)=[]; %Vaciar la lista

    
    ExpansionGrid(NodoExpandido.coorX,NodoExpandido.coorY)=contador;
    contador=contador+1;
    for i=1:size(movimientos,1)
        direction=movimientos(i,:);
        if(NodoExpandido.coorX+ direction(1)<1 || NodoExpandido.coorX+direction(1)>size(laberinto,1)|| NodoExpandido.coorY+ direction(2)<1 || NodoExpandido.coorY+direction(2)>size(laberinto,2))
            continue;
        else
            NuevaCelda=GRID(NodoExpandido.coorX+direction(1),NodoExpandido.coorY+direction(2));
            
             if(NuevaCelda.isChecked~=1 && NuevaCelda.estaVacio~=1) %Si es diferente a visitado o esta vacia la celda
                GRID(NuevaCelda.coorX,NuevaCelda.coorY).gValue=GRID(NodoExpandido.coorX,NodoExpandido.coorY).gValue+costo;
                GRID(NuevaCelda.coorX,NuevaCelda.coorY).isChecked=1; %modified line from the v1
                ListaAbierta=[ListaAbierta,GRID(NuevaCelda.coorX,NuevaCelda.coorY)]; 
                AccionesTomadas(NuevaCelda.coorX,NuevaCelda.coorY)=i;
             end
            
             if(NuevaCelda.coorX==ObjMeta.coorX && NuevaCelda.coorY==ObjMeta.coorY && NuevaCelda.estaVacio~=1)
                SeEncontro=true;
                Resigno=true;
                disp('Busqueda correcta');
                GRID(NuevaCelda.coorX,NuevaCelda.coorY).isChecked=1;
                ExpansionGrid(NuevaCelda.coorX,NuevaCelda.coorY)=contador;
                GRID(NuevaCelda.coorX,NuevaCelda.coorY);
                break;
            end
            
        end
    end

     if(isempty(ListaAbierta) && SeEncontro==false) %Si la lista esta vacia o no se econtro el camino
         Resigno=true; %Se resigna la busqueda
         disp('No se encontro solución');
         break; %Romper ciclo
     end
 end
 CaminoEncontrado=[]; %Arreglo para guardar el camino encontrado.
 if(SeEncontro==true) %Si se encuentra el camino
     Politicas={'Arriba','Izquierda','Abajo','Derecha','Diag Arriba','Diag Abajo'};
     X=meta(1); %Recuperar eje X de la meta
     Y=meta(2); %Recuperar eje y de la meta
     CaminoOptimo(X,Y)={'Meta'};
     
     while(X~=inicio(1)|| Y~=inicio(2)) %Recorrer mientas que los coordenadas no converjan
         waitbar(.75,BarraDeCarga,'Procesando ruta'); % Cambiando el msj de la barra de cargando
         x2=X-movimientos(AccionesTomadas(X,Y),1); %retomando acciones realizadas en x
         y2=Y-movimientos(AccionesTomadas(X,Y),2); %retomando acciones realizadas en y
         CaminoOptimo(x2,y2)=Politicas(AccionesTomadas(X,Y)); %Retomando camino con acciones
         CaminoEncontrado=[CaminoEncontrado;[X,Y]]; %Registrar los puntos al arreglo de lineas 
         X=x2;
         Y=y2;
     end
     waitbar(1,BarraDeCarga,'Finalizando'); %Finalizar barra
     CaminoEncontrado=[CaminoEncontrado;[inicio(1),inicio(2)]]; % Agregar el punto de inicio
     Tiempo_Total=toc %registrar el tiempo que tardo

 else
     waitbar(1,BarraDeCarga,'Finalizando'); %Finalizando barra de carga
     disp('No se encontro camino');
     Tiempo_Total=toc %registrando el tiempo que tardo
 end
 
 close(BarraDeCarga);
end