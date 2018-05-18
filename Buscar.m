%Clase que nos permite guardar el estado de cada nodo de busqueda

classdef Buscar
    
    %Definiendo propiedades del objeto
    properties
        gValue; 
        coorX; %Coordenada x
        coorY; %Coordenada y
        estaVacio; %Esta vacio
        isChecked; %Ya fue checado
        hValue; %Valor de heuristica
    end
    
    methods
        %Funcion para inicializar el objeto buscar
        function obj=Buscar()
            obj.coorX=0; %coordenada x
            obj.coorY=0; %coordenada y
            obj.gValue=0;
            obj.estaVacio=0; %Esta vacio
            obj.isChecked=0; %Ya fue revisado
            obj.hValue=0; %Valor de heuristica
        end
        
        %Seteando nuevos valores al nuevo objeto de busqueda
        function obj=Set(obj,X,Y,Estado,Heuristica)
            obj.coorX=X;
            obj.coorY=Y;
            obj.estaVacio=Estado;
            obj.hValue=Heuristica;
        end
        
    end
end