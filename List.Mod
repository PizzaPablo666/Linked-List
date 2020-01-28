MODULE List;
IMPORT Out;
TYPE

string* = ARRAY 16 OF CHAR;

	node* = POINTER TO nodeDesc;
	nodeDesc = RECORD 
		str : string;
		next, prev : node;
	END;

	list* = POINTER TO listDesc;
	listDesc = RECORD
		first, last: node;
		count : INTEGER;
	END;

   PROCEDURE New*(VAR l: list);
   BEGIN
     NEW(l);
	 l.first := NIL; l.last := NIL;
	 l.count := 0;
   END New;

   PROCEDURE Count*(VAR l: list): INTEGER;
   BEGIN
   RETURN l.count;
   END Count;

   PROCEDURE StrNode*(VAR n : node;  str : string);
   BEGIN
	n.str := str;
   END StrNode;

   PROCEDURE ReturnStr*(VAR n : node; VAR nStr : string);
   BEGIN
	nStr := n.str;
   END ReturnStr;

   PROCEDURE InsertAfter*(VAR l: list; VAR n0, n1: node);
   BEGIN
	IF n0.next = NIL THEN  
		n0.next := n1;
		n1.prev := n0;
		n1.next := NIL;
	ELSE
		n1.next := n0.next;
		n1.prev := n0;
		n0.next.prev := n1;
		n0.next := n1;
	END;
   END InsertAfter;

   PROCEDURE Replace*(VAR newNode, oldNode : node; VAR l : list);
VAR oldPrev, oldNext : node;
   BEGIN
   oldPrev := oldNode.prev;
   oldNext := oldNode.next;
   oldNode.prev := NIL;
   oldNode.next := NIL;
   newNode.next := oldNext;
   newNode.prev := oldPrev;
	IF (oldPrev = NIL) & (oldNext # NIL) THEN
		l.first := NIL;
		l.first := newNode;
	ELSIF (oldPrev # NIL) & (oldNext = NIL) THEN
		l.last := NIL;
		l.last := newNode;
	ELSIF (oldPrev # NIL) & (oldNext # NIL) THEN 
		oldPrev.next := newNode;
		oldNext.prev := newNode;
	ELSE
		Out.String('Something is wrong');
	END;

	IF l.count = 1 THEN 
		l.last := newNode;
		l.first := newNode;
	END;
   END Replace;


   PROCEDURE NewNode*(VAR newNode : node);
   BEGIN
	NEW(newNode);
	newNode.prev := NIL;
	newNode.next := NIL;
   END NewNode;

   PROCEDURE InsertBefore*(VAR l: list; VAR n0, n1: node);
   BEGIN
	IF n1.prev = NIL THEN
		n1.prev := n0;
		n0.next := n1;
		n0.prev := NIL;
	ELSE 
		n0.next := n1;
		n0.prev := n1.prev;
		n1.prev.next := n0;
		n1.prev := n0;
	END;
	INC(l.count);
   END InsertBefore;

   PROCEDURE Insert*(VAR l: list; index: INTEGER; VAR n: node);
VAR currNode: node;
	i : INTEGER;
  BEGIN
	i := index;
	
	IF (index = 0) & (l.count = 0) THEN
		l.first := n;
	ELSE
		currNode := l.first;
		WHILE i-1 # 0 DO
			currNode := currNode.next;
			DEC(i);
		END;
	
		IF l.count = index THEN
			n.next := NIL;
			n.prev := currNode;
			currNode.next := n;
			l.last := n;
		ELSIF index = 0 THEN 
			n.prev := NIL;
			n.next := currNode;
			currNode.prev := n;
			l.first := n;
		ELSE 
			n.next := currNode.next;
			n.prev := currNode;
			currNode.next.prev := n;
			currNode.next := n;
		END;
	END;
			INC(l.count);
   END Insert;

   PROCEDURE Delete*(VAR l: list; n: node);
   BEGIN
	n.prev.next := NIL;
	n.next.prev := NIL;
	DEC(l.count)
   END Delete;

   PROCEDURE Empty*(VAR l :list);
   BEGIN
	l.first := NIL;
	l.last := NIL;
	l.count := 0;
   END Empty;
  
   PROCEDURE Get*(VAR l: list; i: INTEGER): node;
VAR currNode : node;
   BEGIN
	currNode := l.first;
	WHILE i - 1 # 0 DO
	currNode := currNode.next;
	DEC(i);
	END;

	RETURN currNode;
   END Get;

   PROCEDURE Append*(VAR l: list; VAR n: node);
   BEGIN
	n.prev := l.last.prev;
	n.next := NIL;
	l.last.next := n;
	l.last := n;
	INC(l.count);
   END Append;
   
   PROCEDURE AppendList*(VAR l0, l1: list);
VAR i : INTEGER;
	currNode : node;
   BEGIN
	currNode := l1.first;
	WHILE i-1 # 0 DO
		Append(l0, currNode);
	END;

   END AppendList;

   PROCEDURE Prev*( VAR n : node): node;
   BEGIN

	RETURN n.prev; 

   END Prev;

   PROCEDURE Next*(VAR n: node): node;
   BEGIN

	 RETURN n.next;

   END Next;

END List.
