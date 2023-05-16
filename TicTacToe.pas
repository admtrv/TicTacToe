uses GraphWPF;
//uses SpeechABC;

const
  N = 3;

const
  cellSize = 510 div N;

//  Глобальная переменная 
var
  field: array [,] of integer;
  
// Переменные очков  
var ComputerScore:=0;
var PlayerScore:=0;

procedure DrawCross(x, y: integer);
begin
  Pen.Color := Colors.Red;
  Pen.Width := 10;
  Pen.RoundCap := True;
  Line(x * cellSize + 10, y * cellSize + 10, (x + 1) * cellSize - 10, (y + 1) * cellSize - 10);
  Line((x + 1) * cellSize - 10, y * cellSize + 10, x * cellSize + 10, (y + 1) * cellSize - 10);
end;

procedure DrawNolik(x, y: integer);
begin
  Pen.Color := Colors.Green;
  Pen.Width := 10;
  Circle(x * cellSize + (cellsize div 2), y * cellSize + (cellsize div 2), (cellsize div 2) - 20)
end;

procedure DrawField;
begin
  Window.Clear;
  Pen.Color := Colors.gray;
  Pen.Width := 5;
  Pen.RoundCap := True;
  for var i := 1 to N-1  do
  begin
    Line(10, i * cellSize, Window.Width - 10, i * cellSize);
    Line(i * cellsize, 10, i * cellsize, window.Height - 60);
  end;
  for var x := 0 to N - 1 do
    for var y := 0 to N - 1 do
      if field[x, y] = 1 then
        DrawCross(x, y)
      else 
      if field[x, y] = 2 then
        DrawNolik(x, y);
      
   TextOut(20,cellsize*N+15,'Компьютер ');
   TextOut(110,cellsize*N+15,ComputerScore.ToString);
   TextOut(144,cellsize*N+15,':');
   TextOut(170,cellsize*N+15,PlayerScore.ToString);
   TextOut(200,cellsize*N+15,'Игрок');
end;

procedure NolWin;
begin
  Window.Clear;
  Pen.Color := Colors.Green;
  Pen.Width := 10;
  Circle((cellsize * n) div 2, (cellsize * n) div 2, (cellsize div 2) - 20);
  TextOut((cellsize * n) div 2 - (cellsize div 2)+20,((cellsize * n) div 2)+100,'Компьютер победил!');
end;

procedure CrossWin;
begin
  Window.Clear;
  Pen.Color := Colors.Red;
  Pen.Width := 10;
  Pen.RoundCap := True;
  Line((cellsize * n) div 2 - (cellsize div 2),(cellsize * n) div 2 - (cellsize div 2),(cellsize * n) div 2 + (cellsize div 2),(cellsize * n) div 2 + (cellsize div 2));
  Line((cellsize * n) div 2 + (cellsize div 2), (cellsize * n) div 2 - (cellsize div 2),(cellsize * n) div 2 - (cellsize div 2),(cellsize * n) div 2 + (cellsize div 2) );
  TextOut((cellsize * n) div 2 - (cellsize div 2)+30,((cellsize * n) div 2)+100,'Игрок победил!');
end;

procedure Draw;
begin
  Window.Clear;
  Pen.Color := Colors.Red;
  Pen.Width := 10;
  Pen.RoundCap := True;
  Line(10,(cellsize * n) div 2 - (cellsize div 2),cellsize-10,(cellsize * n) div 2 + (cellsize div 2));
  Line(cellsize-10, (cellsize * n) div 2 - (cellsize div 2),10,(cellsize * n) div 2 + (cellsize div 2) );
  Pen.Color := Colors.Green;
  Pen.Width := 10;
  Circle(cellsize*N - (cellsize div 2),(cellsize * n) div 2, (cellsize div 2) -5);
  
  TextOut((cellsize * n) div 2 - (cellsize div 2)+50,((cellsize * n) div 2)+100,'Ничья!');
end;

procedure InitGame;
begin
  field := new integer[N, N];
  Window.SetSize(N * cellSize, N * cellSize + 50);
  Window.CenterOnScreen;
  DrawField;
  Window.Caption := 'Tic-tac-toe game';
end;

function Winner : integer;
begin
  // Функция, определяющая победителя. 0 - ещё нет, 1 - крестики, 2 - нолики, 3 - ничья
  Result := 0;
  for var x := 0 to n - 3  do
    for var y := 0 to n - 1 do
      if (field[x, y]<>0) and (field[x, y]=field[x+1, y]) and (field[x+1, y]=field[x+2, y]) then
        Result := field[x, y];

  for var x := 0 to n - 1  do
    for var y := 0 to n - 3 do
      if (field[x, y]<>0) and (field[x, y]=field[x, y+1]) and (field[x, y+1]=field[x, y+2]) then
        Result := field[x, y];
  
  for var x := 0 to n - 3  do
    for var y := 0 to n - 3 do
      if (field[x, y]<>0) and (field[x, y]=field[x+1, y+1]) and (field[x+1, y+1]=field[x+2, y+2]) then
        Result := field[x, y];

  for var x := 1 to n - 2  do
    for var y := 1 to n - 2 do
      if (field[x, y]<>0) and (field[x-1, y+1]=field[x, y]) and (field[x, y]=field[x+1, y-1]) then
        Result := field[x, y];
  
  if Result <> 0 then exit;
      
  Result := 3;  //  У нас ничья 
  for var x := 0 to n - 1  do
    for var y := 0 to n - 1 do   
      if field[x, y] = 0 then
        begin
          Result := 0;
          exit;
        end;
       
  {//  Если нет свободных клеток, то ничья
  if Result = 0 then 
    Window.Caption := 'Игра в процессе'
  
  else 
  if Result = 1 then 
  begin
    Window.Caption := 'Победили крестики';
    Say('Победили крестики');
  end
  
  else 
    if Result = 2 then 
  begin
    Window.Caption := 'Победили нолики';
    Say('Победили нолики');
  end
  
  else 
    if Result = 3 then 
  begin
    Window.Caption := 'Ничья';
    Say('Ничья');
  end;}
  
end;

procedure ComputerMove;
begin
  for var x:= 0 to n-1 do
    for var y:=0 to n-1 do
    begin
      if field[x,y] = 0 then 
      begin
        field[x,y] := 2;
        if Winner = 2 then exit;
        field[x,y] := 0;
      end;
    end;
    
  for var x:= 0 to n-1 do
    for var y:=0 to n-1 do
      if field[x,y] = 0 then 
      begin
        field[x,y]:=1;
        if (Winner = 1) and (Random < 0.8) then 
          begin 
            field[x,y]:=2;
            exit; 
          end;
        field[x,y] := 0;
      end;
  {Перебрать все пустые клетки. В каждую пробовать поставить 2 (нолик), и если 
   выигрыш,то так и оставить, иначе вернуть назад 0
   
   Перебрать все пустые клетки, В каждую пробовать ставить 1 (крестик), и если
   после этого выигрывает игрок, поставить 2 (нолик), и закончить}
  
  
  var (x,y) := Random2(n);
  while field[x,y] <> 0 do
    (x,y) := Random2(n);
  field[x,y] := 2;
  {Сначала посчитать количество нулевых клеток.
   Далее, случайно выбрать номер клетки, отсчитать от начала 
   поля эту клетку и поставить 2}
end;

procedure PlayerMove(x, y: integer);
begin
  if field[x,y] <> 0 then exit;
  //  Игрок пробует пойти в клетку x,y
  field[x,y] := 1;
  DrawField;
  
  //  Выполняем проверки - какие?
  var wn := Winner;
  if wn = 1 then
  begin
    PlayerScore+=1;
    CrossWin;
    //Say('Победил игрок');
    exit;
  end
  else
    if wn = 3 then
        begin
          PlayerScore+=1;
          ComputerScore+=1;
          Window.Caption := 'Ничья!';
          Draw;
          //Say('Ничья');
          exit;
        end;
  
  //  Делает ход компьютер +
  ComputerMove;
  //  Переисовываем поле +
  DrawField;
  //  Проверки
  wn := Winner;
  if wn = 2 then 
  begin
    ComputerScore+=1;
    NolWin
    //Say('Победил компьютер');
  end
  else
    if wn = 3 then
      begin
        Window.Caption := 'Ничья!';
          //Say('Ничья');
        exit;
      end;
end;

procedure MD(x, y: real; mb: integer);
begin
  if Winner <> 0 then exit;
  var row := Floor(x / cellSize);
  var col := Floor(y / cellSize);
  PlayerMove(row,col);
end;

procedure OnKD(K: Key);
begin
  if k = Key.Space then
    InitGame;
  if k = Key.Escape then
    Window.Close;
end;

begin
  OnMouseDown := MD;
  OnKeyDown := OnKD;
  InitGame;
  //field := new integer[3,3] ((1,2,0),(1,1,0),(2,2,0));
  DrawField;

end.