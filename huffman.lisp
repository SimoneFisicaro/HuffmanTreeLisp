(defun mag-p (L1 L2)
      (if (<  (car (cdr L1)) (car (cdr L2)))
           T
           nil
       ))

(defun flatten (x)
       (cond ((null x) x)
             ((atom x) (list x))
             (T (append (flatten (first x)) (flatten (rest x))))))

;GENERA UN ALBERO DI HUFFMAN DATA IN INPUT UNA LISTA:
;((A 1) (B 2) ...)

(defun generate-huffman-tree (symbols-n-weights)
  (if (< (length symbols-n-weights) 2)
      (error "huffman tree can't be generated with only one symbol or less")
      (generate-tree symbols-n-weights)))

(defun generate-tree (symbols-n-weights)
  (if (null (cdr symbols-n-weights))
      (car symbols-n-weights)
      (let ((a  (stable-sort symbols-n-weights 'mag-p)))
        (generate-tree 
           (append (list (cons 
               (flatten (list (car (car a)) (car (car (cdr a)))))
                  (cons 
                  (+ (car (cdr (car a))) (car (cdr (car (cdr a))))) 
                    (cons (car a) (list (car (cdr a)))))))
                (cdr (cdr a)))))))

(defun node-left (branch)
  (if (not (atom branch))
      (car (cdr (cdr branch)))))

(defun node-right (branch)
  (if (not (atom branch))
      (car (cdr (cdr (cdr branch))))))

(defun leaf-p (branch)
  (cond ((null (cdr (cdr branch))) T)
        (T nil)))

(defun leaf-symbol (leaf)
  (car leaf))

(defun choose-branch (bit branch) 
  (cond ((= 0 bit) (node-left branch))
        ((= 1 bit) (node-right branch)) 
        (t (error "Bad bit ~D. ERROR: while choosing the next branch, tree may be incorrectly generated or be a simple leaf! " bit))))

(defun in-p (L elem)
  (if (null L)
      nil
      (or (eql (if (atom L) L (car L))  elem) (if (not (atom L)) (inp (rest L) elem)))))

;DATA UNA LISTA IN BIT IN INPUT ED UN ALBERO DI HUFFMAN RESTITUISCE LA SUA DECODIFICA
; bits (1 0 0) 
(defun decode (bits huffman-tree)
  (labels ((decode-1 (bits current-branch)
             (unless (null bits)
               (let ((next-branch (choose-branch (first bits) current-branch)))
                 (if (leaf-p next-branch)
                     (cons (leaf-symbol next-branch) (decode-1 (rest bits) huffman-tree)) 
                        (decode-1 (rest bits) next-branch))))))
               (decode-1 bits huffman-tree)))

(defun choose-next-encoding-branch (branch current-symbol)
       (cond ((in-p (car (node-left branch)) current-symbol) (node-left branch))
             ((in-p (car (node-right branch)) current-symbol) (node-right branch))
             (T (error "ERROR: while choosing the next branch, tree may be incorrectly generated or be a simple leaf!"))))

;FORNISCE LA CODIFICA DI UN MESSAGGIO SOTTOFORMA DI LISTA
;DATI IN INPUT UN MESSAGGIO SOTTO FORMA DI LISTA E UN ALBERO DI HUFFMAN             
(defun encode (message huffman-tree)
       (labels ((encode-1 (message current-branch)
                (unless (null message)
                 (let ((next-branch (choose-next-encoding-branch current-branch (first message))))
                      (if (leaf-p next-branch)
                            (if (equal (node-left current-branch) next-branch)
                                    (cons 0 (encode-1 (rest message) huffman-tree))
                                    (cons 1 (encode-1 (rest message) huffman-tree)))
                            (if (equal (node-left current-branch) next-branch)
                                    (cons 0 (encode-1  message (if (inp (car next-branch) (first message)) next-branch huffman-tree)))
                                    (cons 1 (encode-1  message (if (inp (car next-branch) (first message)) next-branch huffman-tree)))))))))
               (encode-1 message huffman-tree)))

;FORNISCE IN OUTPUT UNA LISTA SIMBOLO-CODIFICA PER OGNI SIMBOLO
;CONTENUTO IN UNA FOGLIA DELL'ALBERO DI HUFFMAN DATO IN INPUT
(defun generate-symbol-bits-table (huffman-tree)
       (labels ((read-tree (list)
                 (if  (not (null list))
                      (cons (list (car list) (encode (list (car list)) huffman-tree)) (read-tree (rest list )))
                       nil)))
       (read-tree (car huffman-tree)))) 

