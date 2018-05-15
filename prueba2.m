clear;
komega_path=cell(maxk,maxb-minb);
cost_komega=zeros(maxk,maxb-minb);
ko_time=zeros(maxk,maxb-minb);
komega_dist=zeros(maxk,maxb-minb);


for kt=1:maxk
    for bt=minb:maxb
[komega_path{kt,bt},cost_komega(kt,bt),ko_time(kt,bt),komega_dist(kt,bt)]...
    =komegaA(Astar_coord, Astar_connect, s, d, kt , bt, n); 
    end
end
cost_komega(:,1:minb-1)=[];
ko_time(:,1:minb-1)=[];
komega_dist(:,1:minb-1)=[];

figure(gcf+1)
[xr,xl]=size(cost_komega);
surf(minb:maxb,1:xr,cost_komega);
axis([minb maxb 1 maxk]);
title('K-Omega # of iterations for n=0');
xlabel('b - Parameter');
ylabel('k - Parameter');
zlabel('Number of loops'); view(3);

figure(gcf+1)
[xr,xl]=size(ko_time);
surf(minb:maxb,1:xr,ko_time);
axis([minb maxb 1 maxk]);
title('K-Omega Computation time for n=0');
xlabel('b - Parameter');
ylabel('k - Parameter');
zlabel('Time (Seconds)'); view(3);

figure(gcf+1)
[xr,xl]=size(komega_dist);
surf(minb:maxb,1:xr,komega_dist);
axis([minb maxb 1 maxk]);
title('K-Omega Cost for n=0');
xlabel('b - Parameter');
ylabel('k - Parameter');
zlabel('Cost'); view(3);

