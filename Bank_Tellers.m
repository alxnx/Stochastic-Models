%Megan Morrison -- 2-26-12 -- MATH 3302
%Assignment 6
%We are going to make a simulation for a bank that has two bank tellers.
%We want to figure out how many customers visit the bank. 
T = 1000000; 
TimeIn = zeros(100,100);
lamda = 3; 
mu1 = 2; 
mu2 = 2;
t = 0; 
Q1 = 0; 
Q2 = 0;
while t < T
    if Q1 == 0 && Q2 == 0
        wait = -log(rand)/lamda;
        TimeIn(1,1) = TimeIn(1,1) + wait;
        Q1 = 1; %If both queues are 0, then the customer goes to Q1.
    elseif Q1 == 0 && Q2 > 0
        wait = -log(rand)/(lamda+mu2);
        TimeIn(1,Q2+1) = TimeIn(1,Q2+1) + wait;
        u = rand;
        if u < lamda/(lamda+mu2)
            Q1 = 1;
        else
            Q2 = Q2 - 1;
        end
    elseif Q1 > 0 && Q2 == 0
        wait = -log(rand)/(lamda+mu1);
        TimeIn(Q1+1,1) = TimeIn(Q1+1,1) + wait;
        u = rand;
        if u < lamda/(lamda+mu1)
            Q1 = Q1 + 1;
        else
            Q1 = Q1 - 1; 
            Q2 = Q2 + 1;
        end
    elseif Q1 > 0 && Q2 > 0 && Q1 > Q2
           wait = -log(rand)/(lamda+mu1+1);
           TimeIn(Q1+1,Q2) = TimeIn(Q1+1,Q2) + wait;
           u = rand;
           if u > (lamda+mu1+mu2)/(lamda+mu1)
         Q1 = Q1 + 1;
           else 
             Q1 = Q1 - 1;
             Q2 = Q2 + 1;
           end
    elseif Q1 > 0 && Q2 > 0 && Q2 > Q1
        wait = -log(rand)/(lamda+mu2+1);
        TimeIn(Q1,Q2+1) = TimeIn(Q1,Q2+1) + wait;
        u = rand;
        if u > (lamda+mu1+mu2)/(lamda+mu2)
            Q2 = Q2 + 1;
        else 
             Q1 = Q1 + 1;
             Q2 = Q2 - 1;
        end
        else
        wait = -log(rand)/(lamda+mu1+mu2);
        TimeIn(Q1+1,Q2+1) = TimeIn(Q1+1,Q2+1) + wait;
        u = rand;
        if u < lamda/(lamda+mu1+mu2)
            Q1 = Q1 + 1;
        elseif u < (lamda+mu1)/(lamda+mu1+mu2)
            Q1 = Q1 -1; 
            Q2 = Q2 + 1;
        else
            Q2 = Q2 - 1;
        end
        EQ1 = 0;
        EQ2 = 0;
        for i = 1:100
            for j = 1:100
                EQ1 = EQ1 + (i-1)*TimeIn(i,j)*10;
                EQ2 = EQ2 + (j-1)*TimeIn(i,j)*10;
            end
        end
    end
    t = t + wait;
end
TimeIn = TimeIn/t;
Average = (EQ1 + EQ2)/2;
disp('The expected value of EQ1 is:');
disp(EQ1);
disp('The expected value of EQ2 is:');
disp(EQ2);
disp('The expected value for both queues is:');
disp(Average);