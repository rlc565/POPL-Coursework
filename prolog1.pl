
%question 1

station('AL',[metropolitan]).  		% 'AL' is a station on the metropolitan line
station('LS',[metropolitan, central]).  % 'LS' is a station on the metropolitan and central lines
station('KX',[metropolitan, victoria]).
station('BS',[metropolitan]).
station('FR',[metropolitan]).
station('FP',[victoria]).
station('WS',[victoria, northen]).
station('OC',[victoria, bakerloo, central]).
station('VI',[victoria]).
station('BR',[victoria]).
station('BG',[central]).
station('CL',[central]).
station('TC',[central, northen]).
station('LG',[central]).
station('NH',[central]).
station('EU',[northen]).
station('EM',[northen, bakerloo]).
station('KE',[northen]).
station('EC',[bakerloo]).
station('PA',[bakerloo]).
station('WA',[bakerloo]).

%station('WA', Lines).     => Lines = [bakerloo]
%station('EU',[northen]).  => true
%station('LG',[northen]).  => false

%--------------------------------------------------------------------------------------------------------------------------------------------------------
%question 2

station_exists(Station) :- station(Station, Y). % the station exists if there is a station with that station name regardless of the lines

%station_exists('CL'). => true
%station_exists('XX'). => false

%---------------------------------------------------------------------------------------------------------------------------------------------------------
%question 3

adj('WA', 'PA'). 	%'WA' is adjacent to 'PA'
adj('PA', 'OC').
adj('OC', 'EM').
adj('EM', 'EC').
adj('FR', 'BS').
adj('BS', 'KX').
adj('KX', 'LS').
adj('LS', 'AL').
adj('EU', 'WS').
adj('WS', 'TC').
adj('TC', 'EM').
adj('EM', 'KE').
adj('FP', 'KX').
adj('KX', 'WS').
adj('WS', 'OC').
adj('OC', 'VI').
adj('VI', 'BR').
adj('NH', 'LG').
adj('LG', 'OC').
adj('OC', 'TC').
adj('TC', 'CL').
adj('CL', 'LS').
adj('LS', 'BG').

adjacent(X,Y) :- adj(X,Y) ; adj(Y,X).  %make them adjacent in both directions where X and Y are both stations

%adjacent('LG','NH'). => true
%adjacent('WA','OC'). => false

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%question 4

sameline(Station1,Station2,Line) :- station(Station1,X), member(Line,X),	%there is a Line that is a member of station1's linelist
				station(Station2,Y), member(Line,Y).		%the same Line is also a member of station2's linelist
										%the stations must exist and share a line for a line to be returned

% sameline('WA','PA',bakerloo). => true
% sameline('WA','BS',bakerloo). => false
% sameline('LG','LS',Line).     => Line = central
% sameline('TC','VI',Line).     => false

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%question 5

line(Line, ListOfStations) :-findall(Station,(station(Station,X), member(Line,X)),ListOfStations).	%finds all stations where the line is a member of the stations line list
													%findall groups together all the results into a list and stores it in ListOfStations

%line(northen, ListOfStations). => ListOfStations = ['WS', 'TC', 'EU', 'EM', 'KE']

%-----------------------------------------------------------------------------------------------------------------------
%question 6

station_numlines(Station,NumberOfLines):- station(Station, Lines), length(Lines,NumberOfLines).	%gets list of lines for station then finds the length of the list and returns this as NumberOfLines

%station_numlines('EM', NumberOfLines). => NumberOfLines = 2
%station_numlines('LG', NumberOfLines). => NumberOfLines = 1

%------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%question 7

adjacent2interchange(NonInterStation, InterchangeStation):- adjacent(NonInterStation,InterchangeStation), 	%the interchange station must be adjacent
								station_numlines(InterchangeStation, Y), Y>1, 	%the interchange station must have more than one line going through it to be an interchange
								station_numlines(NonInterStation,Z),Z is 1. 	%the noninterstation must only have one line going through it so its not an interchange
														% if all three clauses are true then it returns the interchange station

%adjacent2interchange('FP', InterchangeStation). => InterchangeStation = 'KX'
%adjacent2interchange('CL', InterchangeStation). => InterchangeStation = 'LS' ; InterchangeStation = 'TC'.
%adjacent2interchange('LS', InterchangeStation). => false

%----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%question 8

route(From, To, Route):- travel(From, To, [From], Q), reverse(Q,Route).   	%there is a route if you can travel from one station to the other with From given as the first visited
										%stations are added to visited in reverse so they need to be reversed back before the final route is returned
travel(From, To, Visited, [To|Visited]) :- adjacent(From,To).			%(base case) if the final destination station is adjacent to the current station then a correct route has been found so To is added to the visited stations and returned as the route taken to get there
travel(From,To,Visited,Route) :- adjacent(From,Next), 				%in order to find a route, a station that is adjacent to the current station must be found to go to next
				Next \== To, 					%Next should not be the final station as this would need to go through the base case in order for the full route to be returned
				\+member(Next,Visited),				%Next can't already be in visited as this would allow for loops in the routes which would result in infinitely many routes
				travel(Next,To,[Next|Visited],Route).		%recursivly call travel to find the next ststion that can be travelled to until it finds the final station then it will go to the base case

%route('WA','PA',Route).  => Route = ['WA', 'PA'] 
%route('WA','TC',Route).  => Route = ['WA', 'PA', 'OC', 'TC'] ;
%			Route = ['WA', 'PA', 'OC', 'EM', 'TC'] ;
%			Route = ['WA', 'PA', 'OC', 'WS', 'TC'] ;
%			Route = ['WA', 'PA', 'OC', 'WS', 'KX', 'LS', 'CL', 'TC']

%-------------------------------------------------------------------------------------------------------------------------------------------------------------
%question 9

route_time(From,To,Route,Minutes) :- route(From, To, Route),  	%find the possible routes
				length(Route,X),              	%find the length of the route (how many stations in route)
				Minutes is (X-1)*4.           	%multiply number of edges between stations (the number of stations -1) by 4 to get minutes
								%this will return the minutes each route takes along with the route so the shortest route can be found

%route_time('WA','OC',Route,Minutes).  =>  Route = ['WA', 'PA', 'OC'], Minutes = 8 ;false
%route_time('EU','LS',Route,Minutes).  =>  Route = ['EU', 'WS', 'TC', 'CL', 'LS'], Minutes = 16 ;
%				Route = ['EU', 'WS', 'OC', 'EM', 'TC', 'CL', 'LS'], Minutes = 24 ;
%				Route = ['EU', 'WS', 'OC', 'TC', 'CL', 'LS'], Minutes = 20 ;
%				Route = ['EU', 'WS', 'KX', 'LS'], Minutes = 12 ;
%				false.

