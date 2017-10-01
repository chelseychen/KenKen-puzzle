;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define-struct puzzle (size board constraints))
;; A Puzzle = (make-puzzle 
;;               Nat 
;;               (listof (listof (union Symbol Nat Guess))
;;               (listof (list Symbol Nat Symbol)))
(define-struct guess (symbol number))
;; A Guess = (make-guess Symbol Nat)

(define puzzle5
  (make-puzzle 
   5
   (list
    (list 'p 'p 'e 'b 'b)
    (list 'h 'p 'e 'k 'a)
    (list 'h 'e 'e 'a 'a)
    (list 'h 'c 'c 'c 'd)
    (list 'g 'g 'd 'd 'd))
   (list
    (list 'a 10 '+)
    (list 'b 2 '/)
    (list 'c 30 '*)
    (list 'd 16 '+)
    (list 'e 12 '*)
    (list 'g 1 '-)
    (list 'h 8 '+)
    (list 'k 3 '=)
    (list 'p 100 '*))))

(define puzzle5partial1
  (make-puzzle 
   5
   (list
    (list '5 4 (make-guess 'e 3) 'b 'b)
    (list 'h 5 'e 'k 'a)
    (list 'h 2 'e 'a 'a)
    (list 'h 'c (make-guess 'c 5) 'c 'd)
    (list 'g 'g 'd 'd 'd))
   (list
    (list 'a 10 '+)
    (list 'b 2 '/)
    (list 'c 30 '*)
    (list 'd 16 '+)
    (list 'e 12 '*)
    (list 'g 1 '-)
    (list 'h 8 '+)
    (list 'k 3 '=))))

(define puzzle5partial2
  (make-puzzle 
   5
   (list
    (list 'p 'p 'e (make-guess 'b 2) (make-guess 'b 1))
    (list 'h 'p 'e 'k 1)
    (list 'h 'e 'e 4 5)
    (list 'h 'c 'c 'c 'd)
    (list 'g 'g 'd 'd 'd))
   (list
    (list 'b 2 '/)
    (list 'c 30 '*)
    (list 'd 16 '+)
    (list 'e 12 '*)
    (list 'g 1 '-)
    (list 'h 8 '+)
    (list 'k 3 '=)
    (list 'p 100 '*))))

(define puzzle5partial3
  (make-puzzle 
   5
   (list
    (list 'p 'p 'e (make-guess 'b 3) (make-guess 'b 2))
    (list 'h 'p 'e 'k 1)
    (list 'h 'e 'e 4 5)
    (list 'h 'c 'c 'c 'd)
    (list 'g 'g 'd 'd 'd))
   (list
    (list 'b 2 '/)
    (list 'c 30 '*)
    (list 'd 16 '+)
    (list 'e 12 '*)
    (list 'g 1 '-)
    (list 'h 8 '+)
    (list 'k 3 '=)
    (list 'p 100 '*))))

(define puzzle5soln
  (make-puzzle 
   5
   (list
    (list 5 4 3 1 2)
    (list 4 5 2 3 1)
    (list 3 2 1 4 5)
    (list 1 3 5 2 4)
    (list 2 1 4 5 3))
   empty))

(define puzzle6
  (make-puzzle 
   5
   (list
    (list 'c 'b 'b 'b 'b)
    (list 'c 'h 'e 'b 'd)
    (list 'h 'h 'e 'f 'f)
    (list 'a 'h 'g 'g 'i)
    (list 'a 'a 'i 'i 'i))
   (list
    (list 'a 4 '+)
    (list 'b 72 '*)
    (list 'c 20 '*)
    (list 'd 1 '=)
    (list 'e 2 '/)
    (list 'f 1 '-)
    (list 'g 3 '-)
    (list 'h 13 '+)
    (list 'i 240 '*))))

(define puzzle1
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 'd 'e 'e)
    (list 'f 'd 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'd 5 '+)
    (list 'e 3 '-)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1
(define puzzle1partial
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
(define puzzle1partial2
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
;; but not yet verified 
(define puzzle1partial3
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; The solution to puzzle 1
(define puzzle1soln
  (make-puzzle
   4
   '((2 1 4 3)
     (3 2 1 4)
     (4 3 2 1)
     (1 4 3 2))
   empty))

;; wikipedia KenKen example
(define puzzle2
  (make-puzzle
   6
   '((a b b c d d)
     (a e e c f d)
     (h h i i f d)
     (h h j k l l)
     (m m j k k g)
     (o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (j 6 *)
     (k 7 +)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; The solution to puzzle 2
(define puzzle2soln
  (make-puzzle
   6
   '((5 6 3 4 1 2)
     (6 1 4 5 2 3)
     (4 5 2 3 6 1)
     (3 4 1 2 5 6)
     (2 3 6 1 4 5)
     (1 2 5 6 3 4))
   empty))

;; Tiny board
(define puzzle3
  (make-puzzle 
   2 
   '((a b) 
     (c b)) 
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))

(define puzzle3partial
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 1))
    (list 'c (make-guess 'b 2)))
      '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

;;==============================================================================
;; Part (a)
;; find-blank: Puzzle -> (union Posn false 'guess)
;; find a blank space in the puzzle, or return false if the puzzle is complete
;; Examples
(check-expect (find-blank puzzle1) (make-posn 0 0))
(check-expect (find-blank puzzle1soln) false)
(define (find-blank puz)
  (cond
    [(empty? (puzzle-constraints puz)) false]
    [else
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
         (y board cage (make-posn 0 0))))]))
;; Tests
(check-expect (find-blank puzzle1partial2) (make-posn 0 1))
(check-expect (find-blank puzzle1partial3) 'guess)
(check-expect (find-blank puzzle3partial) 'guess)
(check-expect (find-blank puzzle5partial1) (make-posn 4 1))
(check-expect (find-blank puzzle5partial2) 'guess)
(check-expect (find-blank puzzle5soln) false)
;;==============================================================================
;; Part (b)
;; used-in-row: Puzzle Posn -> (listof nat)
;; produce the list of numbers used in the same row as the (x,y) location
;; in the puzzle
;; Examples
(check-expect (used-in-row puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))
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
;; Tests
(check-expect (used-in-row puzzle5partial1 (make-posn 2 0)) '(3 4 5))
(check-expect (used-in-row puzzle5partial1 (make-posn 4 4)) empty)
(check-expect (used-in-row puzzle5partial1 (make-posn 1 3)) '(5))
;; used-in-column: puzzle posn -> (listof nat)
;; produce the list of numbers used in the same column as the (x,y) location
;; in the puzzle
;; Examples
(check-expect (used-in-column puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-column puzzle1partial (make-posn 2 2)) (list 1))
(check-expect (used-in-column puzzle1partial2 (make-posn 0 1)) (list 2))
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
;; Tests
(check-expect (used-in-column puzzle5partial1 (make-posn 0 3)) '(5))
(check-expect (used-in-column puzzle5partial1 (make-posn 1 4)) '(2 4 5))
(check-expect (used-in-column puzzle5partial1 (make-posn 2 2)) '(3 5))
;;==============================================================================
;; Part (c)
;; allvals : Nat -> (listof Nat)
;; This function may be useful in available-vals
;; Examples
(check-expect (allvals 0) empty)
(check-expect (allvals 1) (list 1))
(define (allvals n) (build-list n (lambda (x) (add1 x))))
;; Tests:
(check-expect (allvals 3) (list 1 2 3))

;; available-vals: Puzzle Posn -> (listof Nat)
;; produce the list of valid entries for the (x,y) location of the puzzle
;; Examples
(check-expect (available-vals puzzle1 (make-posn 2 3)) '(1 2 3 4))
(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))
(define (available-vals puz pos)
  (local [(define num (allvals (puzzle-size puz)))
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
;; Tests
(check-expect (available-vals puzzle5partial1 (make-posn 1 3)) '(1 3))
(check-expect (available-vals puzzle5partial1 (make-posn 2 2)) '(1 4))
;;==============================================================================
;; Part (d)
;; place-guess: (listof (listof (union Symbol Nat Guess))) Posn Nat 
;;              -> (listof (listof (union Symbol Nat Guess)))
;; fill in the (x,y) location of the board puz with val
;; Examples
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 3 2) 5)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g (make-guess 'g 5))
               (list 'f 'h 'i 'i)))
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 2 1) 3)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd (make-guess 'e 3) 'e)
               (list 'f 'd 'g 'g)
               (list 'f 'h 'i 'i)))
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
;; Tests
(check-expect (place-guess (puzzle-board puzzle5) (make-posn 4 4) 4)
              (list
               (list 'p 'p 'e 'b 'b)
               (list 'h 'p 'e 'k 'a)
               (list 'h 'e 'e 'a 'a)
               (list 'h 'c 'c 'c 'd)
               (list 'g 'g 'd 'd (make-guess 'd 4))))
(check-expect (place-guess (puzzle-board puzzle5) (make-posn 2 2) 2)
              (list
               (list 'p 'p 'e 'b 'b)
               (list 'h 'p 'e 'k 'a)
               (list 'h 'e (make-guess 'e 2) 'a 'a)
               (list 'h 'c 'c 'c 'd)
               (list 'g 'g 'd 'd 'd)))
;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; fill in the (x,y) location of puz with val
;; Examples
(check-expect (fill-in-guess puzzle1 (make-posn 2 1) 3)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd (make-guess 'e 3) 'e)
                (list 'f 'd 'g 'g)
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))
(check-expect (fill-in-guess puzzle1 (make-posn 3 2) 5)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd 'e 'e)
                (list 'f 'd 'g (make-guess 'g 5))
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))
(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))
;; Tests
(check-expect (fill-in-guess puzzle5 (make-posn 4 4) 4)
              (make-puzzle
               5
               (list
                (list 'p 'p 'e 'b 'b)
                (list 'h 'p 'e 'k 'a)
                (list 'h 'e 'e 'a 'a)
                (list 'h 'c 'c 'c 'd)
                (list 'g 'g 'd 'd (make-guess 'd 4)))
               (puzzle-constraints puzzle5)))
(check-expect (fill-in-guess puzzle5 (make-posn 2 2) 2)
              (make-puzzle
               5
               (list
                (list 'p 'p 'e 'b 'b)
                (list 'h 'p 'e 'k 'a)
                (list 'h 'e (make-guess 'e 2) 'a 'a)
                (list 'h 'c 'c 'c 'd)
                (list 'g 'g 'd 'd 'd))
               (puzzle-constraints puzzle5)))
;;==============================================================================
;; Part (e)
;; guess-valid? : Puzzle -> Boolean
;; verify that the guesses made on the board are valid
;; Examples
(check-expect (guess-valid? puzzle3partial) true)
(check-expect (guess-valid? puzzle1partial3) true)
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
;; Tests
(check-expect (guess-valid? puzzle5partial2) true)
(check-expect (guess-valid? puzzle5partial3) false)
;;==============================================================================
;; Part (f)
;; apply-guess:  Puzzle -> Puzzle
;; apply the guesses by converting them into numbers and removing the first element
;; from the constraints
;; Examples
(check-expect (apply-guess puzzle3partial)
              (make-puzzle
               2 
               (list
                (list 'a 1)
                (list 'c 2))
               '((c 2 =)
                 (a 1 =))))
(check-expect (apply-guess puzzle1partial3)
              (make-puzzle 
               4
               (list
                (list 2 'b 'b 'c)
                (list 3 2 1 4)
                (list 'f 3 'g 'g)
                (list 'f 'h 'i 'i))
               (list
                (list 'b 3 '-)
                (list 'c 3 '=)
                (list 'f 3 '-)
                (list 'g 2 '/)
                (list 'h 4 '=)
                (list 'i 1 '-)))) 
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
;; Tests
(check-expect (apply-guess puzzle5partial2)
              (make-puzzle 
               5
               (list
                (list 'p 'p 'e 2 1)
                (list 'h 'p 'e 'k 1)
                (list 'h 'e 'e 4 5)
                (list 'h 'c 'c 'c 'd)
                (list 'g 'g 'd 'd 'd))
               (list
                (list 'c 30 '*)
                (list 'd 16 '+)
                (list 'e 12 '*)
                (list 'g 1 '-)
                (list 'h 8 '+)
                (list 'k 3 '=)
                (list 'p 100 '*))))
(check-expect (apply-guess puzzle5partial3)
              (make-puzzle 
               5
               (list
                (list 'p 'p 'e 3 2)
                (list 'h 'p 'e 'k 1)
                (list 'h 'e 'e 4 5)
                (list 'h 'c 'c 'c 'd)
                (list 'g 'g 'd 'd 'd))
               (list
                (list 'c 30 '*)
                (list 'd 16 '+)
                (list 'e 12 '*)
                (list 'g 1 '-)
                (list 'h 8 '+)
                (list 'k 3 '=)
                (list 'p 100 '*))))
;;==============================================================================
;; Part (g)
;; neighbours: Puzzle -> (listof Puzzle)
;; produce a list of next puzzles in the implicit graph
;; Examples
(check-expect (neighbours puzzle2soln) empty)
(check-expect (neighbours puzzle3partial)
              (list 
               (make-puzzle
                2 
                (list
                 (list 'a 1)
                 (list 'c 2))
                '((c 2 =)
                  (a 1 =)))))
(check-expect (neighbours puzzle3)
              (list 
               (make-puzzle 
               2 
               (list 
                (list 'a (make-guess 'b 1)) 
                (list 'c 'b)) 
               '((b 3 +) 
                 (c 2 =)
                 (a 1 =)))
                 (make-puzzle 
               2 
               (list 
                (list 'a (make-guess 'b 2)) 
                (list 'c 'b)) 
               '((b 3 +) 
                 (c 2 =)
                 (a 1 =)))))
(define (neighbours puz)
  (local [(define outcome (find-blank puz))]
    (cond
      [(false? outcome) empty]
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
;; Tests
(check-expect (neighbours puzzle5partial2)
              (list
               (make-puzzle 
                5
                (list
                 (list 'p 'p 'e 2 1)
                 (list 'h 'p 'e 'k 1)
                 (list 'h 'e 'e 4 5)
                 (list 'h 'c 'c 'c 'd)
                 (list 'g 'g 'd 'd 'd))
                (list
                 (list 'c 30 '*)
                 (list 'd 16 '+)
                 (list 'e 12 '*)
                 (list 'g 1 '-)
                 (list 'h 8 '+)
                 (list 'k 3 '=)
                 (list 'p 100 '*)))))
(check-expect (neighbours puzzle5partial3) empty)

;; solve-kenken: Puzzle -> (union Puzzle false)
;; find a solution to a KenKen puzzle, or return false if there is no
;; solution
;; Examples
(check-expect (time (solve-kenken puzzle1)) puzzle1soln)
(check-expect (solve-kenken puzzle5) puzzle5soln)
(check-expect (solve-kenken puzzle6) puzzle5soln)
(define (solve-kenken orig)
  (local
    [(define (solve-kenken-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [(boolean? (find-blank (first to-visit))) (first to-visit)]
         [(member (first to-visit) visited)
          (solve-kenken-helper (rest to-visit) visited)]
         [else
          (local [(define nbrs (neighbours (first to-visit)))
                  (define new (filter (lambda (x) (not (member x visited))) nbrs))
                  (define new-to-visit (append new (rest to-visit)))
                  (define new-visited (cons (first to-visit) visited))]
            (solve-kenken-helper new-to-visit new-visited))]))]
    (solve-kenken-helper (list orig) empty)))
;; Tests
(check-expect (time (solve-kenken puzzle2)) puzzle2soln)
(check-expect (solve-kenken puzzle3) 
              (make-puzzle 
               2 
               '((1 2) 
                 (2 1)) 
               empty))
(check-expect (solve-kenken puzzle3partial) false)