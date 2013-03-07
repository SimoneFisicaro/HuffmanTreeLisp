
# README Progetto #

GENERATE-HUFFMAN-TREE

La funzione generate-huffman-tree permette di costruire un albero di Huffman, servendosi di una lista di coppie (a loro volta aventi struttura di lista) e di due ulteriori funzioni ausiliarie, magp e flatten. 
La lista symbols-n-weights è costruita:

	((A 1) (B 3) … )

Il predicato mag-p è stato definito in merito alla necessità di ordinare, mediante la funzione stable-sort una lista di liste, definendo dunque una relazione d'ordinamento tra due elementi:

	(A 1)  < (B 3)

La funzione flatten (definita a lezione) permette di ottenere a partire da una lista contenete delle sotto-liste a profondità variabile, una lista costituita dai medesimi elementi della prima, ma composta da un unico livello.

	(flatten '((A) B))

	(A B)
         
Un esempio di chiamata della funzione generate-huffman-tree è la seguente:

	(generate-huffman-tree '((a 5) (b 1) (c 2) (d 8)))

	((B C A D) 16 ((B C A) 8 ((B C) 3 (B 1) (C 2)) (A 5)) (D 8))

Non è ammessa la chiamata con un solo simbolo e peso nella lista symbols-n-weights poiché non è possibile generare un albero di huffman sensato, nel caso in cui questo non sia costruito a partire da almeno una coppia di elementi.

ENCODE

La funzione encode permette la codifica di un messaggio dato in input sotto forma di lista di elementi:

	(A B C …)

La codifica avviane mediante la consultazione di un albero di Huffman (Ht), che costituisce una struttura per la codifica secondo l'uso del metodo omonimo.
Un esempio di chiamata è la seguente:

	(encode '(A B) ht)

	(0 1 0 0 0)

DECODE

La funzione decode compie il lavoro opposto della della funzione encode, utilizzando una metodologia di chiamata analoga, in input accetta una lista di bit generati dalla funzione di codifica ed un huffman tree.

GENERATE-SYMBOL-TABLE-BITS

Per ottenere una codifica dei simboli registrati nelle foglie dell'albero di huffman, generato dalla funzione generate-huffman-tree, è possibile servirsi della funzione generate-symbol-table-bits. La funzione restituisce una lista di coppie (strutturate come liste a loro volta) del tipo simbolo-codifica.
Un esempio di chiamata:

	(generate-symbol-bits-table ht)

	((B (0 0 0)) (C (0 0 1)) (A (0 1)) (D (1)))

FUNZIONI AUSILIARIE

Sono presenti nel file alcune altre funzioni ausiliarie di fondamentale importanza, quali node-left, node-right, leaf-p, leaf-symbol, choose-branch, choose-next-encoding-branch ed in-p. Delle funzioni elencate occorre specificare la semantica di in-p e choose-next-encoding-branch. La funzione in-p è semanticamente un predicato che restituisce T nel caso in cui nella lista L sia presente l'elemento "elem". La funzione choose-next-encoding-branch è semanticamente identica alla funzione choose-branch, ne differisce per il modo di operare nella ricerca del ramo da considerare il prossimo utile per la codifica, valutando come corretto quello che contiene nell'elencazione dei nodi contenuti nel sotto albero, quello in cui sia presente il simbolo da codificare. 

 