; NAME: Joshua Alexander
; Prints output and saves .gv file at the filePath variable below. The file is overwritten after each run if it already exisits.

(#%require racket)

(define sCtr 2)
(define tCtr (+ sCtr 1))
(define lvl sCtr)
(define outStr "digraph jalexa14_parser {\n\t{1 [label=\"Grammar\"]};\n")
(define filePath "./jalexa14_sentence_parse.gv")

; Terminal Grammar Functions
(define (article str)
  (if (eq? 'a (string->symbol (string-downcase str)))
      (begin  (printNonTerminal "Article" sCtr) (printTerminal str) (parse-next))
      (if (eq? 'the (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Article" sCtr) (printTerminal str) (parse-next))
          (begin (printf "Article expected but found \"~a\"\n" (first s)) (parse-next)))))

(define (conjunction str)
  (if (eq? 'and (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Conjunction" 1) (printTerminal str) (parse-next))
      (if (eq? 'or (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Conjunction" 1) (printTerminal str) (parse-next))
          (begin (printf "Conjunction expected but found \"~a\"\n" (first s)) (parse-next)))))

(define (noun str)
  (if (eq? 'dog (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Noun" sCtr) (printTerminal str) (parse-next))
      (if (eq? 'cat (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Noun" sCtr) (printTerminal str) (parse-next))
          (if (eq? 'mouse (string->symbol (string-downcase str)))
              (begin (printNonTerminal "Noun" sCtr) (printTerminal str) (parse-next))
              (if (eq? 'tree (string->symbol (string-downcase str)))
                  (begin (printNonTerminal "Noun" sCtr) (printTerminal str) (parse-next))
                  (if (eq? 'cheese (string->symbol (string-downcase str)))
                      (begin (printNonTerminal "Noun" sCtr) (printTerminal str) (parse-next))
                      (begin (printf "Noun expected but found \"~a\"\n" (first s)) (parse-next))))))))

(define (preposition str)
  (if (eq? 'of (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Preposition" sCtr) (printTerminal str) (parse-next))
      (if (eq? 'around (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Preposition" sCtr) (printTerminal str) (parse-next))
          (begin (printf "Preposition expected but found \"~a\"\n" (first s)) (parse-next)))))

(define (verb str)
  (if (eq? 'likes (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Verb" lvl) (printTerminal str) (parse-next))
      (if (eq? 'hates (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Verb" lvl) (printTerminal str) (parse-next))
          (if (eq? 'eats (string->symbol (string-downcase str)))
              (begin (printNonTerminal "Verb" lvl) (printTerminal str) (parse-next))
              (if (eq? 'chases (string->symbol (string-downcase str)))
                  (begin (printNonTerminal "Verb" lvl) (printTerminal str) (parse-next))
                  (begin (printf "Verb expected but found \"~a\"\n" (first s)) (parse-next)))))))

(define (adverb str)
  (if (eq? 'quickly (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Adverb" lvl) (printTerminal str) (parse-next))
      (if (eq? 'slowly (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Adverb" lvl) (printTerminal str) (parse-next))
          (if (eq? 'quietly (string->symbol (string-downcase str)))
              (begin (printNonTerminal "Adverb" lvl) (printTerminal str) (parse-next))
              (begin (printf "Adverb expected but found \"~a\"\n" (first s)) (parse-next))))))

(define (adjective str)
  (if (eq? 'fast (string->symbol (string-downcase str)))
      (begin (printNonTerminal "Adjective" lvl) (printTerminal str) (parse-next))
      (if (eq? 'slow (string->symbol (string-downcase str)))
          (begin (printNonTerminal "Adjective" lvl) (printTerminal str) (parse-next))
          (if (eq? 'furry (string->symbol (string-downcase str)))
              (begin (printNonTerminal "Adjective" lvl) (printTerminal str) (parse-next))
              (if (eq? 'yellow (string->symbol (string-downcase str)))
                  (begin (printNonTerminal "Adjective" lvl) (printTerminal str) (parse-next))
                  (begin (printf "Adjective expected but found \"~a\"\n" (first s)) (parse-next)))))))

(define (eos str)
  (if (eq? '! (string->symbol str))
      (begin (printNonTerminal "Terminator" sCtr) (printTerminal str) (parse-next))
      (if (eq? '\. (string->symbol str))
          (begin (printNonTerminal "Terminator" sCtr) (printTerminal str) (parse-next))
          (begin (printf "Terminator expected but found \"~a\"\n" (first s)) (parse-next)))))

(define (comma str)
  (if (eq? '\, (string->symbol str))
      (begin (printNonTerminal "Comma" lvl) (printTerminal str) (parse-next))
      (begin (printf "Comma expected but found \"~a\"\n" (first s)) (parse-next))))

; Helper Functions
(define (isArticle str)
  (if (eq? 'a (string->symbol (string-downcase str))) #t
      (if (eq? 'the (string->symbol (string-downcase str))) #t
          #f )))

(define (isConjunction str)
  (if (eq? 'and (string->symbol (string-downcase str))) #t
      (if (eq? 'or (string->symbol (string-downcase str))) #t
          #f )))

(define (isNoun str)
  (if (eq? 'dog (string->symbol (string-downcase str))) #t
      (if (eq? 'cat (string->symbol (string-downcase str))) #t
          (if (eq? 'mouse (string->symbol (string-downcase str))) #t
              (if (eq? 'tree (string->symbol (string-downcase str))) #t
                  (if (eq? 'cheese (string->symbol (string-downcase str))) #t
                      #f ))))))

(define (isPreposition str)
  (if (eq? 'of (string->symbol (string-downcase str))) #t
      (if (eq? 'around (string->symbol (string-downcase str))) #t
          #f )))

(define (isVerb str)
  (if (eq? 'likes (string->symbol (string-downcase str))) #t
      (if (eq? 'hates (string->symbol (string-downcase str))) #t
          (if (eq? 'eats (string->symbol (string-downcase str))) #t
              (if (eq? 'chases (string->symbol (string-downcase str))) #t
                  #f )))))

(define (isAdverb str)
  (if (eq? 'quickly (string->symbol (string-downcase str))) #t
      (if (eq? 'slowly (string->symbol (string-downcase str))) #t
          (if (eq? 'quietly (string->symbol (string-downcase str))) #t
              #f ))))

(define (isAdjective str)
  (if (eq? 'fast (string->symbol (string-downcase str))) #t
      (if (eq? 'slow (string->symbol (string-downcase str))) #t
          (if (eq? 'furry (string->symbol (string-downcase str))) #t
              (if (eq? 'yellow (string->symbol (string-downcase str))) #t
                  #f )))))

(define (isEOS str)
  (if (eq? '! (string->symbol str)) #t
      (if (eq? '\. (string->symbol str)) #t
          #f )))

(define (isComma str)
  (if (eq? '\, (string->symbol str)) #t
      #f))

(define (spaceGrammar str)
  (set! str (string-replace str "." " ."))
  (set! str (string-replace str "!" " !"))
  (set! str (string-replace str "," " ,"))
  (format str))

(define (printTerminal term)
  (set! tCtr (+ tCtr 1))
  (printf "\t{~a [label=\"~a\", shape=rect]}; ~a->~a;\n" tCtr term (- tCtr 1) tCtr)
  (set! outStr (string-append outStr (format "\t{~a [label=\"~a\", shape=rect]}; ~a->~a;\n" tCtr term (- tCtr 1) tCtr))))

(define (printNonTerminal term pNum)
  (printf "\t{~a [label=\"~a\"]}; ~a->~a;\n" tCtr term pNum tCtr)
  (set! outStr(string-append outStr (format "\t{~a [label=\"~a\"]}; ~a->~a;\n" tCtr term pNum tCtr))))

(define (parse-next)
  (if (< (length s) 2) (display "") (begin (set! tCtr (+ tCtr 1)) (set! s (list-tail s 1)))))

; Non-Terminal Grammar Functions
(define (sentence_tail)
  (cond ((isConjunction (first s)) (begin
         (set! sCtr (+ sCtr tCtr))
         (set! lvl sCtr)
         (conjunction (first s))
         (set! tCtr (+ tCtr 1))
         (sentence)))
        (else (eos (first s)))))

(define (adj_list)
  (cond ((isAdjective (first s))
         (cond ((isComma (second s)) (begin
                (printNonTerminal "Adjective List" sCtr)
                (set! lvl tCtr)
                (set! tCtr (+ tCtr 1))
                (adjective (first s))
                (adj_tail)))
               (else (begin (adjective (first s)) (adj_tail))))
         (set! lvl sCtr))
        (else
         (cond ((isNoun (first s)) (display ""))
                    (else (begin (printf "Adjective expected but found \"~a\"\n" (first s)) (parse-next)))))))

(define (adj_tail)
  (cond ((isComma (first s)) (begin
         (comma (first s))
         (adj_list)))
        (else (display ""))))

(define (pp)
  (cond ((isPreposition (first s)) (begin
         (preposition (first s))
         (np)))
        (else (display ""))))

(define (vp)
  (cond ((isAdverb (first s)) (begin
         (printNonTerminal "Verb Phrase" sCtr)
         (set! lvl tCtr)
         (set! tCtr (+ tCtr 1))
         (adverb (first s))
         (verb (first s))
         (set! lvl sCtr)))
        (else (verb (first s)))))

(define (np)
  (cond ((isArticle (first s)) (begin
         (article (first s))
         (adj_list)
         (noun (first s))
         (pp)))
        (else (noun (first s)))))

(define (sentence)
  (printf "\t{~a [label=\"Sentence\"]}; 1->~a;\n" sCtr sCtr)
  (set! outStr (string-append outStr (format "\t{~a [label=\"Sentence\"]}; 1->~a;\n" sCtr sCtr)))
  (np)
  (vp)
  (np)
  (sentence_tail))

(define (parser)
  (printf "\n\ndigraph jalexa14_parser {\n\t{1 [label=\"Grammar\"]};\n")
  (sentence)
  (printf "}")
  (set! outStr (string-append outStr "}")))

; Start Parsing Calls
(display "Enter Sentence: ")
(define input (read-line))

(define s (string-split (spaceGrammar input)))
(display (format "\n~a" input))

(parser)

; Write to file
(define out (open-output-file filePath #:mode 'text #:exists 'replace))
(fprintf out outStr)
(printf "\n\nFile saved to ~a" filePath)
(close-output-port out)