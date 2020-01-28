MODULE testList;
IMPORT List, Out;


VAR
	dog, planet, human : List.list;
	Rex,Max,Ralph,Loki,
	Uranus, Saturn, Mercury,
	Gagik, Vahe : List.node;
	
	RexStr,MaxStr : List.string;

	BEGIN

	List.New(dog);
	List.New(planet);
	List.New(human);

	List.NewNode(Rex);
	
	List.Insert(dog,0,Rex);
	
	List.StrNode(Rex, "I am Rex");

	List.ReturnStr(Rex, RexStr);
	Out.String(RexStr);

	List.NewNode(Max);
	List.StrNode(Max, "I am Max");
	List.Append(dog,Max);
	List.ReturnStr(List.Next(Rex), MaxStr);
	Out.String(MaxStr);
(*	
	List.InsertAfter(dog,Rex,Max);
	List.InsertAfter(dog,Max,Ralph);
	List.InsertAfter(dog,Ralph,Loki);

	List.StrNode(Rex, "I am Rex");
	List.StrNode(Max, "I am Max");
	List.StrNode(Ralph, "I am Ralph");
	List.StrNode(Loki, "I am Loki");*)



	(*List.ChangeListFirst(dog, Max);
	Out.String(dog.first.str); Out.Ln;
	Out.String(dog.first.next.str);Out.Ln;*)

	Out.Int(List.Count(dog), 0); Out.Ln;




END testList.
