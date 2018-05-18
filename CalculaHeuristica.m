function [Heuristica]=CalculaHeuristica(tablero,meta) %Funcion que permite calcular la Heuristica
                                                   %Recibe como parametros el tablero y la meta.
                                                   %Regresa la Heuristica
                                                   %del nodo [X , Y]

Heuristica=zeros(size(tablero)); %Crea un arreglo de ceros del tamanio del tablero

for i=1:size(tablero,1)  % recorre el tablero de en su primera dimension
    for j=1:size(tablero,2) %Recorre  el tablero en su segunda dimension
        Heuristica(i,j)=abs(i-meta(1))+abs(j-meta(2)); 
        %Heuristica[x,y] = valorAbsoluto(la posicion del nodo menos la meta
        %en la dimension 1)+ valorAbsoluto(La posicion del nodo menos la meta en la dimesion 3)
    end
end

end
