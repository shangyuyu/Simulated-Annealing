% Initialize cities and canvas

N = 30;  % Number of cities

% New canvas
city = rand(N, 2);
visitOrder = 1:N;
global distCity
distCity = zeros(N, N);

for i = 1:N
    for j = 1:N
    
        distCity(i, j) = sqrt((city(i, 1)-city(j, 1))^2 + (city(i, 2)-city(j, 2))^2);
    end
end

figure;
plot(city(:, 1), city(:, 2), 'LineStyle', 'none', 'Marker', 'o');
hold on;
