% simulated annealing

maxIteration = 60000;
numCandPerIteration = 50;
decTempCount = 3000;
alpha = 1;  % 1 / temperature

% annealing
record = zeros(numCandPerIteration, 2);
    %           cityNo  cityNo2  transformation  expCost
    % choice1
    % choice2
    % ...       ...
decCount = 0;

for i = 1:maxIteration
   
    cost_ = calcCost(visitOrder);
    
    if (decCount == decTempCount)
    
        alpha = alpha + 10;
        decCount = 0;
    end
    flag = false;  % whether find a better order
    for j = 1:numCandPerIteration
        
        c1 = randi(N);  % the chosen segment is between visitOrder(c1) -> visitOrder(c1+1)
        record(j, 1) = c1;
        c2 = randi(N);
        record(j, 2) = c2;

        if (randi(2) >= 1)  % Reverse
            
            record(j, 3) = 1;  % Record transformation

            newVisitOrder = visitOrder;
            newVisitOrder([c1 c2]) = newVisitOrder([c2 c1]);
            cost = calcCost(newVisitOrder);  % cost of this choice
            if (cost < cost_)
                
                visitOrder([c1 c2]) = visitOrder([c2 c1]);
                flag = true;
                decCount = decCount + 1;
                break;
            end
            expCost = exp(alpha * (cost_ - cost));
            record(j, 4) = expCost;  % Record expCost
        else  % Transport

            % It is suggested to add another way to change the 
            % order (except swap), which will accelerate converge
            % But since it has been working now, I dont want bother
            % optimize this...
        end
    end
    
    % randomly choose one
    if ~flag
    
        chosen = randsample(numCandPerIteration, 1, true, record(:, 4));
        
        visitOrder([record(chosen, 1), record(chosen, 2)]) = visitOrder([record(chosen, 2), record(chosen, 1)]);
    end
end

plot(city([visitOrder, visitOrder(1)], 1), city([visitOrder, visitOrder(1)], 2));


% Functions
function cost = calcCost(visitOrder)
    
    global distCity
    cost = 0;
    
    for i = 1:length(visitOrder)-1
    
        cost = cost + distCity(visitOrder(i), visitOrder(i+1));
    end
    cost = cost + distCity(visitOrder(length(visitOrder)), visitOrder(1));
end


