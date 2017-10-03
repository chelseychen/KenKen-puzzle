;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken-bonus) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define-struct puzzle (size board constraints))
;; A Puzzle = (make-puzzle 
;;               Nat 
;;               (listof (listof (union Symbol Nat Guess))
;;               (listof (list Symbol Nat Symbol)))
(define-struct guess (symbol number))
;; A Guess = (make-guess Symbol Nat)

(define puzzle1
  (make-puzzle
   9
   '((a a b c d e e f f)
     (g h b c d i j k l)
     (g h m m i i j k l)
     (n o m p p q q r s)
     (n o t u p v v r s)
     (n w t u x x y z z)
     (A w B C C C y D D)
     (A B B E E F G H I)
     (J J K K F F G H I))
   '((a 2 /)
     (b 11 +)
     (c 1 -)
     (d 7 *)
     (e 4 -)
     (f 9 +)
     (g 1 -)
     (h 4 /)
     (i 108 *)
     (j 13 +)
     (k 2 -)
     (l 5 -)
     (m 84 *)
     (n 24 *)
     (o 40 *)
     (p 18 *)
     (q 2 /)
     (r 2 -)
     (s 13 +)
     (t 10 +)
     (u 13 +)
     (v 2 -)
     (w 63 *)
     (x 1 -)
     (y 3 /)
     (z 2 /)
     (A 7 +)
     (B 13 +)
     (C 336 *)
     (D 1 -)
     (E 15 +)
     (F 12 *)
     (G 9 +)
     (H 5 -)
     (I 18 *)
     (J 3 /)
     (K 40 *))))

(define puzzle2
  (make-puzzle
   9
   '((a a b b c d d e e)
     (a f f g c h h e i)
     (j f k g l l m n i)
     (j o o p q q m n i)
     (r r s t t u v w w)
     (x y s t u u v w z)
     (x y A A B B C C z)
     (D D E E F F C C G)
     (D H H H F I I G G))
   '((a 40 *)
     (b 3 +)
     (c 1 -)
     (d 2 -)
     (e 567 *)
     (f 18 *)
     (g 8 *)
     (h 1 -)
     (i 105 *)
     (j 2 -)
     (k 4 =)
     (l 7 +)
     (m 2 -)
     (n 4 /)
     (o 2 -)
     (p 4 =)
     (q 8 -)
     (r 1 -)
     (s 40 *)
     (t 315 *)
     (u 18 +)
     (v 6 *)
     (w 48 *)
     (x 6 -)
     (y 1 -)
     (z 7 +)
     (A 14 +)
     (B 4 /)
     (C 120 *)
     (D 21 +)
     (E 4 -)
     (F 126 *)
     (G 15 +)
     (H 189 *)
     (I 4 /))))

;; find-blank: Puzzle -> (union Posn 'guess)
;; find a blank space in the puzzle
(define (find-blank puz)
  (local
    [(define cage 
       (first (first (puzzle-constraints puz))))
     (define board (puzzle-board puz))
     ;; guess : (listof (union Symbol Nat Guess)) Symbol Posn -> (union false Posn)
     ;; produces the position of the first cell to fill in
     ;; or produces false if no such a cell
     (define (guess lst cage acc)
       (cond
         [(empty? lst) false]
         [(equal? (first lst) cage)
          acc]
         [else (guess (rest lst)
                      cage
                      (make-posn
                       (add1 (posn-x acc))
                       (posn-y acc)))]))]
    (local
      ;; y : (listof (listof (union Symbol Nat Guess))) Symbol Posn -> (union Symbol Posn)
      ;; produces the position of the first cell to fill in
      ;; or symbol 'guess if only guesses exist in the first constraint
      [(define (y board cage acc)
        (cond
          [(empty? board) 'guess]
          [else
           (local
             [(define a1 (guess (first board) cage acc))]
             (cond
               [(false? a1) 
                (y (rest board)
                   cage
                   (make-posn 0 (add1 (posn-y acc))))]
               [else a1]))]))]
      (y board cage (make-posn 0 0)))))

;; used-in-row: Puzzle Posn -> (listof nat)
;; produce the list of numbers used in the same row as the (x,y) location
;; in the puzzle
(define (used-in-row puz pos)
  (quicksort
   (filter 
    number? 
    (map
     (lambda (x)
       (cond
         [(guess? x) (guess-number x)]
         [else x]))
     (list-ref 
      (puzzle-board puz)
      (posn-y pos)))) <))

;; used-in-column: puzzle posn -> (listof nat)
;; produce the list of numbers used in the same column as the (x,y) location
;; in the puzzle
(define (used-in-column puz pos)
  (quicksort
   (filter
    number?
    (map
     (lambda (x)
       (cond
         [(guess? x) (guess-number x)]
         [else x]))
     (map (lambda (x) (list-ref x (posn-x pos)))
          (puzzle-board puz)))) <))

;; available-vals: Puzzle Posn -> (listof Nat)
;; produce the list of valid entries for the (x,y) location of the puzzle
(define (available-vals puz pos)
  (local [(define num (build-list (puzzle-size puz) (lambda (x) (add1 x))))
          (define row (used-in-row puz pos))
          (define column (used-in-column puz pos))]
    (quicksort
     (filter
      (lambda (x)
        (not 
         (member? x
                  (foldr 
                   (lambda (x y)
                     (cons x (filter
                              (lambda (s)
                                (not (= x s))) y)))
                   empty
                   (foldr cons row column)))))
      num) <)))

;; place-guess: (listof (listof (union Symbol Nat Guess))) Posn Nat 
;;              -> (listof (listof (union Symbol Nat Guess)))
;; fill in the (x,y) location of the board puz with val
(define (place-guess brd pos val)
 (cond
   [(= (posn-y pos) 0)
    (cons 
     (local
       ;; f : (listof (union Symbol Nat Guess)) Nat Nat -> (listof (union Symbol Nat Guess))
       ;; places a guess structure in the given position
       [(define (f lst n val)
          (cond
            [(= n 0) 
             (cons (make-guess (first lst) val)
                   (rest lst))]
            [else
             (cons (first lst)
                   (f (rest lst) (sub1 n) val))]))]
       (f (first brd) (posn-x pos) val))
     (rest brd))]
   [else
    (cons (first brd)
          (place-guess
           (rest brd)
           (make-posn
            (posn-x pos)
            (sub1 (posn-y pos)))
           val))]))

;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; fill in the (x,y) location of puz with val
(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))

;; guess-valid? : Puzzle -> Boolean
;; verify that the guesses made on the board are valid
(define (guess-valid? puz)
 (local
   [(define board (puzzle-board puz))
    (define firstsym (first (first (puzzle-constraints puz))))
    (define firstval (second (first (puzzle-constraints puz))))
    (define firstop (third (first (puzzle-constraints puz))))
    (define guesslist 
      (foldr append empty 
             (map (lambda (x) (filter guess? x)) board)))
    (define firstguess
      (map guess-number 
           (filter (lambda (x)
                     (symbol=? 
                      firstsym
                      (guess-symbol x))) guesslist)))]
   (cond
     [(symbol=? firstop '=)
      (= (first firstguess) firstval)]
     [(symbol=? firstop '+)
      (= (foldr + 0 firstguess) firstval)]
     [(symbol=? firstop '*)
      (= (foldr * 1 firstguess) firstval)]
     [(symbol=? firstop '-)
      (= (abs (- (first firstguess)
                 (second firstguess)))
         firstval)]
     [(symbol=? firstop '/)
      (local [(define a (first firstguess))
              (define b (second firstguess))]
        (cond
          [(>= a b)
           (= (/ a b) firstval)]
          [else
           (= (/ b a) firstval)]))])))

;; apply-guess:  Puzzle -> Puzzle
;; apply the guesses by converting them into numbers and removing the first element
;; from the constraints
(define (apply-guess puz)
  (local
    [(define board (puzzle-board puz))
     (define cst (puzzle-constraints puz))
     (define sym (first (first cst)))
     (define newcst 
       (filter
        (lambda (x)
          (not (symbol=? sym (first x))))
        cst))
     (define newboard
       (map 
        (lambda (x)
          (map
           (lambda (y)
             (cond
               [(guess? y)
                (guess-number y)]
               [else y])) x))
        board))]
    (make-puzzle
     (puzzle-size puz)
     newboard
     newcst)))

;; neighbours: Puzzle -> (listof Puzzle)
;; produce a list of next puzzles in the implicit graph
(define (neighbours puz)
  (local [(define outcome (find-blank puz))]
    (cond
      [(posn? outcome)
       (local
         [(define vals (available-vals puz outcome))]
         (map 
          (lambda (x)
            (fill-in-guess puz outcome x))
          vals))]
      [else
       (local [(define a (guess-valid? puz))]
         (cond
           [(false? a) empty]
           [else (list (apply-guess puz))]))])))

;; solve-kenken: Puzzle -> (union Puzzle false)
;; find a solution to a KenKen puzzle, or return false if there is no solution
(define (solve-kenken orig)
  (local
    [(define (solve-kenken-helper to-visit)
       (cond
         [(empty? to-visit) false]
         [(empty? (puzzle-constraints (first to-visit))) (first to-visit)]
         [else
          (local [(define nbrs (neighbours (first to-visit)))
                  (define new-to-visit (append nbrs (rest to-visit)))]
            (solve-kenken-helper new-to-visit))]))]
    (solve-kenken-helper (list orig))))

(check-expect
 (time (solve-kenken puzzle1))
 (make-puzzle
  9
  (list
   (list 4 2 6 3 7 5 9 8 1)
   (list 6 4 5 2 1 9 8 7 3)
   (list 7 1 2 6 3 4 5 9 8)
   (list 3 8 7 1 9 2 4 5 6)
   (list 1 5 9 4 2 8 6 3 7)
   (list 8 7 1 9 5 6 3 2 4)
   (list 2 9 3 8 6 7 1 4 5)
   (list 5 6 4 7 8 3 2 1 9)
   (list 9 3 8 5 4 1 7 6 2))
  empty))

(check-expect
 (time (solve-kenken puzzle2))
 (make-puzzle
  9
  (list
   (list 4 5 1 2 3 6 8 7 9)
   (list 2 1 3 8 4 7 6 9 5)
   (list 3 6 4 1 2 5 9 8 7)
   (list 5 8 6 4 1 9 7 2 3)
   (list 6 7 8 9 5 1 2 3 4)
   (list 1 2 5 7 9 8 3 4 6)
   (list 7 3 9 5 8 2 4 6 1)
   (list 9 4 2 6 7 3 5 1 8)
   (list 8 9 7 3 6 4 1 5 2))
  empty))