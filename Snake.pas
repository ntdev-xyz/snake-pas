{Trabalho - Estrutura de Dados
 Professor: Franklin
 Alunos:    Nelson Matheus G. De Toledo        RA: 56358
	        Erick Wesley Sakagami              RA: 62754
 Exercício: Snake; }

Program snake;

Uses
	crt;
	
Type
	TpPonteiro = ^TpPont;
	
	TpInfo = record
		x : integer;
		y : integer;
	End;
 
    TpPont = record
        info : TpInfo;
        prox : TpPonteiro;
    End;
 
    TpFila = record
        inicio : TpPonteiro;
        fim    : TpPonteiro;
    End;
	
	TpFruta = record
		x : integer;
		y : integer;
	End;
	
Var
	F,P : TpFila;
	a,b,pont,conft,nivel,contft,cox,coy : integer;
	dir,aux,dif : char;
	fruta : TpFruta;
	frutaOn, Comeu, gameover : boolean;
	
Procedure InicializaFila(var F:TpFila);
Begin
	F.inicio := nil;
	F.fim := nil;
End;

Function FilaVazia(F:TpFila):boolean;
Begin
	FilaVazia := F.inicio = nil;
End;

Procedure InsereFila(var F:TpFila;a:integer;b:integer);
Var
	P : TpPonteiro;
Begin
	New(P);
	P^.info.x := a;
	P^.info.y := b;
	P^.prox := nil;
	If FilaVazia(F) Then
		F.inicio := P
	Else Begin
		F.fim^.prox := P;
	End;
	F.fim := P;
End;

Procedure RemoveFila(var F:TpFila;var a:integer;var b:integer);
Var
	P : TpPonteiro;
Begin
	If NOT FilaVazia(F) Then
	Begin
		P := F.inicio;
		F.inicio := F.inicio^.prox;
		a := P^.info.x;
		b := P^.info.y;
		dispose(P);
		If FilaVazia(F) Then
			F.fim := nil;
	End;
End;

Procedure InicializaParede(var P:TpFila);
Var
	x: integer;
	y: integer;
Begin
	InicializaFila(P);
	x:=1;
	y:=1;
	For x:=1 to 40 do
	Begin
		InsereFila(P,x,y);
		GOTOxy(P.fim^.info.x,P.fim^.info.y);
		textbackground(white);
		Write(' ');
		textbackground(black);
	End;
	For y:=1 to 25 do
	Begin
	InsereFila(P,x,y);
		GOTOxy(P.fim^.info.x,P.fim^.info.y);
		textbackground(white);
		Write(' ');
		textbackground(black);
	End;
	For x:=40 downto 1 do
	Begin
	InsereFila(P,x,y);
		GOTOxy(P.fim^.info.x,P.fim^.info.y);
		textbackground(white);
		Write(' ');
		textbackground(black);
	End;
	For y:=25 downto 1 do
	Begin
	InsereFila(P,x,y);
		GOTOxy(P.fim^.info.x,P.fim^.info.y);
		textbackground(white);
		Write(' ');
		textbackground(black);
	End;
End;

Procedure movimento(var F:TpFila;dir:char);
Var
	P : TpPonteiro;
	x : integer;
	y : integer;
Begin
	If dir = 'd' then
	Begin
		x := F.fim^.info.x + 1;
		y := F.fim^.info.y;
		InsereFila(F,x,y);
		gotoxy(F.fim^.info.x,F.fim^.info.y);
		textbackground(green);
		Write(' ');
		textbackground(black);		
	End;
	If dir = 'w' then
	Begin
		x := F.fim^.info.x;
		y := F.fim^.info.y - 1;
		InsereFila(F,x,y);
		gotoxy(F.fim^.info.x,F.fim^.info.y);
		textbackground(green);
		Write(' ');
		textbackground(black);		
	End;
	If dir = 's' then
	Begin
		x := F.fim^.info.x;
		y := F.fim^.info.y + 1;
		InsereFila(F,x,y);
		gotoxy(F.fim^.info.x,F.fim^.info.y);
		textbackground(green);
		Write(' ');
		textbackground(black);		
	End;
	If dir = 'a' then
	Begin
		x := F.fim^.info.x - 1;
		y := F.fim^.info.y;
		InsereFila(F,x,y);
		gotoxy(F.fim^.info.x,F.fim^.info.y);
		textbackground(green);
		Write(' ');
		textbackground(black);		
	End;
	gotoxy(F.inicio^.info.x,F.inicio^.info.y);
	Write(' ');
	If Comeu = false then
		RemoveFila(F,a,b);
End;

Procedure GeraFruta;
Var
	P : TpPonteiro;
Begin
	contft := 50;
	frutaOn := TRUE;
	fruta.x := random(37) + 2;
	fruta.y := random(21) + 2;
	P := F.inicio;
	Repeat
		If (P^.info.x = fruta.x) AND (P^.info.y = fruta.y) then
			fruta.x := random(37) + 2;
			fruta.y := random(21) + 2;
		P := P^.prox
	Until P^.prox = nil; 
	gotoxy(fruta.x,fruta.y);
	Write('0');
End;

Procedure Colisao(F:TpFila;var gameover:boolean);
Var
	P, P2 : TpPonteiro;
Begin
	If (F.fim^.info.x >= 40) OR (F.fim^.info.y >= 25) OR (F.fim^.info.x <= 1) OR (F.fim^.info.y <= 1) then
		gameover := true;
	P := F.fim;
	P2 := F.inicio;
	Repeat
		If (P2^.info.x = P^.info.x) AND (P2^.info.y = P^.info.y) then
			gameover := true;
		P2 := P2^.prox;
	Until (P2^.prox = nil) OR (gameover = true);
End;

Procedure menu();
Begin
	clrscr;
	Gotoxy(35,12);
	Writeln('Snake');
	Gotoxy(35,13);
	Writeln('v 1.0');
	Gotoxy(22,15);
	Writeln('Por Nelson Toledo e Erick Sakagami');
	Gotoxy(1,1);
	Delay(3000);
	clrscr;
	Gotoxy(20,10);
	Writeln('Selecione uma dificuldade abaixo');
	Gotoxy(25,12);
	Writeln('1 - Newbie');
	Gotoxy(25,13);
	Writeln('2 - Easy');
	Gotoxy(25,14);
	Writeln('3 - Normal');
	Gotoxy(25,15);
	Writeln('4 - Hard');
	Gotoxy(25,16);	
	Writeln('5 - Professional');
	Gotoxy(25,17);
	Writeln('6 - Nerd Rage');
	Gotoxy(25,18);
	Writeln('7 - Awesome Power of Chaos of Dangerous and Excellence');
	dif := readkey;
	case dif of
		'1': nivel := 360;
		'2': nivel := 250;
		'3': nivel := 180;
		'4': nivel := 100;
		'5': nivel := 50;
		'6': nivel := 25;
		'7': nivel := 15;
	end;
End;

Procedure jogo();
Begin
	randomize;
	cox := 20;
	coy := 10;
	frutaOn := false;
	clrscr;
	InicializaParede(P);
	dir := 'd';
	InicializaFila(F);
	InsereFila(F,20,10);
	InsereFila(F,21,10);
	InsereFila(F,22,10);
	gameover := false;
	pont := 0;
	While (gameover = false) Do
	Begin
		If frutaOn = false Then
		Begin
			GeraFruta;
		End;
		Repeat
			movimento(F,dir);
			Comeu := false;
			If (F.fim^.info.x = fruta.x) AND (F.fim^.info.y = fruta.y) AND (frutaOn = true) then
			Begin
				Comeu := true;
				frutaOn := false;
				pont := pont + contft;
				GeraFruta;
			End;
			If contft > 0 then
				contft := contft - 1;
			Delay(nivel);
			aux := dir;
			Colisao(F,gameover);
		Until (keypressed) or (gameover = true); // END REPEAT
		If not gameover then
			dir := readkey
		Else
			dir := 'e';
		If (aux = 'd') AND (dir = 'a') then
			dir := 'd';
		If (aux = 'a') AND (dir = 'd') then
			dir := 'a';
		If (aux = 'w') AND (dir = 's') then
			dir := 'w';
		If (aux = 's') AND (dir = 'w') then
			dir := 's';
		If (dir<>'w') and (dir<>'a') and (dir<>'s') and (dir<>'d') then
			dir := aux
	End; // END WHILE
	Gotoxy(45,8);
	Writeln('GAME OVER');
	Gotoxy(45,10);
	Writeln('Pontos: ',pont);
	Delay(2000);
	clrscr;
	Gotoxy(30,10);
	Writeln('Deseja reiniciar o jogo?');
	Gotoxy(30,12);
	Writeln('S - SIM');
	Gotoxy(30,13);
	Writeln('N - NAO');
	aux := Readkey;
	Case aux of
		's': Begin
				menu;
				jogo;
			 End;
		'n': Begin
				clrscr;
				Gotoxy(30,10);
				Writeln('Thank you for playing...');
				Delay(2000);
			End;
	end;
End;

BEGIN
	menu;
	jogo;
END.