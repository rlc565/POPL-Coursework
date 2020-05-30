#lang racket

;called by running (define P (a-game number)) where P is the name of the instance (player name) and number is the players initial balance
(define ( a-game number) ;create procedure a-game with parameter number

  ;question 6 -----------------------------------------------------------------------------
  ;called by running ((P 'increasemoney)) where P is an instance of a-game
  (define (increasemoney) ;create procedure increasemoney
    (display "Game Player, previously you had: ")
    (display number)
    (display " pound(s)") ;give player previous balance
    (newline) ;go onto next line
    (display "You have scored 1 point, and been awarded 1 pound by theGame Machine!") ;tell them they've gained a point
    (newline)
    (set! number (+ number 1)) ;increment players balance by one
    number
    (display "you now have: ")
    (display number)
    (display " pound(s)")) ;give player new balance

  ;question 4 --------------------------------------------------------------------------------
  ;called by running ((P 'decreasemoney)) where P is an instance of a-game
  (define (decreasemoney)
    (display "Game Player, previously you had: ")
    (display number)
    (display " pound(s)") ;give player previous balance
    (newline)
    (display "You have lost, Game Machine is deducting 2 pounds from your account!")
    (newline)
    (set! number (- number 2)) ;decrement players balance by 2
    number
    (display "you now have: ")
    (display number)
    (display " pound(s)") ;give player new balance
    (newline)
    (if (>= number 2) ;if player has enough credit to continue (more than 2)
        (display "You still have enough credit to play.") ;tell them they can carry on playing
        (display ". . Sorry, you are out of credit, which you can't continue to play. To continue playing, you need to topup. See you soon!!!"))) ;else tell them they're out of money

  ;question 2 ---------------------------------------------------------------------------------
  ;used to call other procedures
  (define (the-game-number request)
    (define (unknown) (display ". . unknown request ") (display request)) ; set an error message
    (cond ((equal? request 'randomnum) randomnum) ;if request is randomnum run random num
          ((equal? request 'increasemoney) increasemoney) ;else if request is increasemoney run increasemoney
          ((equal? request 'decreasemoney) decreasemoney) ;else if request is decreasemoney run decreasemoney
          ((equal? request 'topup) topup) ;else if request is topup run topup
          (else unknown))) ;(display request) ;else give error message if request is something else
    ;cond statment will run first statement found to be true and ignore the others
  
  ;question 3 ---------------------------------------------------------------------------------
  ;called by running ((P 'randomnum)random) where P is an instance of a-game
  (define (randomnum random)
    (set! random (+ 2 (random 49))) ;set variable random to a value between 0 and 48 then add 2 so it gives random number in range 2-51
    random
    (newline)
    (display "The random number is: ")
    (display random) ;display computers random number
    (newline)
    (display "Game Player, your number is: ")
    (display number) ; display players chosen number
    (newline)
    (display "If your number is less than or equal the random number, you lose, otherwise you win.")
    (if (<= number random) ; if the players number is less than or equal to the computers random number
        (begin
          (newline)
          (display "Unfortunately, you have lost, Game Machine will deduct 2 pounds from your account.") ; tell player they have lost and will lose money
          )
        (begin
          (newline)
          (display "Great, you have won, Game Machine will add one pound in your account.")))) ;else tell player they have won and will gain money

  ;question 5 ----------------------------------------------------------------------------------
  ;called by running ((P 'topup)) where P is an instance of a-game and t is the amount you want to topup to
  (define (topup t)
    (set! number t) ; set the players balance to the topup amount
    (newline)
    (display "Game Player, you just topped up: ")
    (display number)
    (display " pound(s)") ; display the players new balance
    (newline)
    (if (and (<= t 30) (>= t 2)) ; if the players balance is a valid amount (between 2 and 30)
        (display "Great, you can play now") ; tell them they can play
        (display ". . Wrong,number/amount should be a minimum of 2 pounds and a maximum of 30 pounds"))) ; else tell them its not a valid amount

  ;question 1 -----------------------------------------------------------------------------------
  (newline)
  (display "Game Player, you decide to go with number:")
  (display number) ;display the players balance
  (newline)
  (if (and (<= number 30) (>= number 2)) ;when new a-game is instantiated, if the number given is a valid amount (between 2 and 30)
      (display "GREAT!!!
Remember, in the game, if the player wins, then he scores 1 point [Game Machine will increase player's account(number) by 1 pound, and deduct 2 pounds from its account].
If the player loses, then he will lose 2 points [Game Machine will deduct 2 pounds from player's account(number), and add 1 pound in its account].
During the game, if the player doesn’t have any credit, then the game ends. The player can start a new game by re-register with a deposit.
Generating a random number is now requested. Game Machine is about to generate a random number and compare it with the player's number.") ;tell player the rules
      (display ". . Wrong, number/amount should be a minimum of 2 pounds and a maximum of 30 pounds")) ;else tell player the amount isn't valid if they enterd an invalid amount
  the-game-number) ; lets you call the-game-number

;-------------------------------------------------------------------------------------------------------------------------------------------------

;when starting introduce game and give rules
(display "Hello and welcome to CLOSURE game!!")
(newline)
(display "DESCRIPTION OF THE GAME!!!")
(newline)
(display "Game Machine will ask a player to make a deposit (minimum of 2 pounds and a maximum of 30 pounds).")
(newline)
(display "The amount of money the player gave will be treated as his number which is required to play in the game.")
(newline)
(display "Next, Game Machine will generate a random number and compare it with the player's number.")
(newline)
(display "If the player's number is less than or equal to the random number, then player loses.")
(newline)
(display "If the player's number is greater than the random number, then player wins.")
(newline)
(display "If the player wins, then he scores 1 point [Game Machine will increase player's account (number) by 1 pound, and deduct 2 pounds from its account].")
(newline)
(display "If the player loses, then he will lose 2 points [Game Machine will deduct 2 pounds from player's account(number), and add 1 pound in its account].")
(newline)
(display "During the game, if the player doesn't have any credit, then the game ends. The player can start a new game by re-register with a deposit.")
(newline)
(newline)

;--------------------------------------------------------------------------------------------------------------------------------------------

;create game machine

;question 7
;calling (define game_machine_amount number) also allows the game machine to be topped up
(define game_machine_amount 0) ;give initial game machine amount
;can be overwritten by calling (define game_machine_amount number) where number is the amount you want the game machine to start with

;question 8 - called by running (game_machine_decrement)
(define (game_machine_decrement)
  (display "Game Machine, before you had: ")
  (display game_machine_amount)
  (display " pound(s)") ;give game machines previous balance
  (newline)
  (set! game_machine_amount (- game_machine_amount 2)) ;decrement game machines balance by 2
  (display "you now have: ")
  (display game_machine_amount)
  (display " pound(s)") ;give game machines new balance
  (newline)
  (if (> game_machine_amount 1) ;if game machine has enough credit to continue (more than 1)
      (display "Game Machine, there is still enough money in the machine for a game to be played") ;tell them they can carry on playing
      (display ". . Game Machine, there isn't any credit in the machine for a game to be played, needs to top up"))) ; tell them they need to topup

;question 9 - called by running (game_machine_increment)
(define (game_machine_increment) ;create procedure game_machine_decrement
    (display "Game Machine, before you had: ")
    (display game_machine_amount)
    (display " pound(s)") ;give game machines previous balance
    (newline) 
    (set! game_machine_amount (+ game_machine_amount 1)) ;increment game machines balance by one
    (display "you now have: ")
    (display game_machine_amount)
    (display " pound(s)")) ;give game machines new balance       
