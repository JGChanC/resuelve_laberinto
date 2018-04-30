function [img,inicio,final] = busqueda(img,inicio,final)
  %% Init data
 
  maze = img > 0;
  start = round(inicio);
  finish = round(final);

  %% Init BFS
  n = numel(maze);
  Q = zeros(n, 2);
  M = zeros([size(maze) 2]);
  front = 0;
  back = 1;

  function push(p, d)
    q = p + d;
    if maze(q(1), q(2)) && M(q(1), q(2), 1) == 0
      front = front + 1;
      Q(front, :) = q;
      M(q(1), q(2), :) = reshape(p, [1 1 2]);
    end
  end

  push(start, [0 0]);

  d = [0 1; 0 -1; 1 0; -1 0];

  %% Run BFS
  while back <= front
    p = Q(back, :);
    back = back + 1;
    for i = 1:4
      push(p, d(i, :));
    end
  end

  %% Extracting path
  path = finish;
  while true
    q = path(end, :);
    p = reshape(M(q(1), q(2), :), 1, 2);
    path(end + 1, :) = p;
    if isequal(p, start) 
      break;
    end
  end
end