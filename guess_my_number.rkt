#lang racket
;; Guess My Number - a simple number guessing game
;; William Nelson-Smith 2015

#|

This program provides functions to allow the computer to play 'Guess My Number'

The player thinks of a number between a range they decide
The computer takes the two range numbers and adds them together and divides them by 2
The computer does that so it knows whether your number is in the bottom half of the range or the top
The thinker then telss the computer whether the guess needs to be higher or lower
In order to play the player needs ot know three commands:

(start) - This starts the game and sets the range each time
(higher) - This tells the computer it needs to guess higher
(lower) - This tells the computer it needs to guess lower

|#


;; Set default values for low and high
(define low 1)
(define high 10)


#|
(start l h)

Starts the game and sets the range the computer will be guessing from to whatever number the player chooses it to be.

Imagine starting the game with a friend, where you are the player doing the guessing,
and your friend is the one thinking of a number.
Your friend might say: I'm thinking of a number between 1 and 50 - can you guess what it is?

This function starts a game like this, where l is the variable which sets the bottom (or lowest number)
of the range and h is the variable which sets the top (or highest number) of the range.

For example:

(start 30 90)

This will tell the computer that you are thinking of a number between 30 and 90, and it should start guessing now.
|#

(define (start l h) 
  (set! low l) 
  (set! high h)
  (guess))

#|

(lower)

This tells the computer that its next guess needs to be lower.

For example, the player thinks '13':

(start 1 50)
(guess)

The computer guesses 25.

(lower)

The computer now calculates the middle number between 1 and the last guess which in this case was 25.  It does this by
 shortening the guessing range to be between 1 and 24 as it takes away one because 25 was too high.
|#

(define (lower)
 (set! high (sub1 (guess)))
  (guess))

(define (higher)
  (set! low (add1 (guess)))
  (guess))


; The guess function finds the number in the middle of the range
; This is called a binary search
; It works by taking the two range values (low and high)
; and adding them together, and then finding the midpoint
; by dividing by 2.
; But sometimes (if the result of low+high is even)
; the mid point will be a fraction
; We only want to guess integers, so in the case of a
; fraction we guess only the whole part of the number

(define (guess) (truncate (/ (+ high low) 2)))
