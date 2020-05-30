%part(i)

sum([],0).                                     %if empty list add 0 to sum (base case)
sum([X|L],Sum) :- sum(L,Y), Sum is Y + X.      %find the sum of the tail of the list and add head of list (X) to sum

%recursivly adds the head of the list to the sum until the list is empty then returns sum

%sum([2,4,6],X).  =>  X = 12
%sum([1,4,5,2],X). => X = 12

%----------------------------------------------------------------------------------------------------------------
%part(iii)

desc([_]).                                 %return if only one element in list (base case)
desc([X,Y|Z]) :- desc([Y|Z]), X >= Y.       %check all but first also in descending order and that first element is greater than second element

%desc([5,2,1]).  => true
%desc([5,4,0,2]).  => false