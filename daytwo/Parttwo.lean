/- 
A => Rock 
B => Paper
C => Scissors
-/
inductive OpponentMove : Type 
| Arock | Bpaper | Cscissors 


/- 
X => Rock 
Y => Paper
Z => Scissors
-/
inductive MeMove : Type 
| Xrock | Ypaper | Zscissors


/- 
X => Rock 
Y => Paper
Z => Scissors
-/
inductive Move : Type 
| X | Y | Z


/- 
Result 
-/
inductive Result : Type 
| Win | Lose | Tie

open Move Result 
def moveInter : Move -> Result 
| X => Lose 
| Y => Tie 
| Z => Win 

/-
def moveResult  (m : MeMove) (o : OpponentMove) : Result :=
match m, o with
| Xrock, Cscissors => Win 
| Xrock, Bpaper => Lose 
| Ypaper, Arock => Win 
| Ypaper, Cscissors => Lose 
| Zscissors, Bpaper => Win 
| Zscissors, Arock => Lose 
| _, _ => Tie 
-/

/-
Rock defeats Scissors,
Scissors defeats Paper, 
and Paper defeats Rock. 
If both players choose the same shape, 
the round instead ends in a draw.
-/
open OpponentMove MeMove
def moveComp (o : OpponentMove) (m : Move) : MeMove :=
match o, (moveInter m) with 
| Arock, Lose => Zscissors
| Arock, Tie => Xrock 
| Arock, Win => Ypaper
| Bpaper, Lose => Xrock
| Bpaper, Tie => Ypaper
| Bpaper, Win => Zscissors
| Cscissors, Lose => Ypaper
| Cscissors, Tie => Zscissors
| Cscissors, Win => Xrock


def shapeValue : MeMove -> Nat 
| Xrock => 1 
| Ypaper => 2 
| Zscissors => 3

def resultScore : Result -> Nat 
| Win => 6
| Lose => 0 
| Tie => 3 


def computeScore : OpponentMove × Move -> Nat 
| (o, m) => resultScore (moveInter m) + 
  shapeValue (moveComp o m)



#eval (List.map computeScore 
  [(Arock, Y), (Bpaper, X), (Cscissors, Z)])


def parse_input (c : String) : OpponentMove × Move :=
match c.trim.toList with 
| ['A', _, 'X'] => (OpponentMove.Arock, Move.X)
| ['A', _, 'Y'] => (OpponentMove.Arock, Move.Y)
| ['A', _, 'Z'] => (OpponentMove.Arock, Move.Z)
| ['B', _, 'X'] => (OpponentMove.Bpaper, Move.X)
| ['B', _, 'Y'] => (OpponentMove.Bpaper, Move.Y)
| ['B', _, 'Z'] => (OpponentMove.Bpaper, Move.Z)
| ['C', _, 'X'] => (OpponentMove.Cscissors, Move.X)
| ['C', _, 'Y'] => (OpponentMove.Cscissors, Move.Y)
| ['C', _, 'Z'] => (OpponentMove.Cscissors, Move.Z)
/- Arbitrary -/
| _ => (OpponentMove.Cscissors, Move.Z)

def solveGame : List (OpponentMove × Move) -> List Nat :=
  fun xs => List.map computeScore xs 

def addList : List Nat -> Nat :=
  fun xs => List.foldl (fun x y => x + y) 0 xs 


def main : IO Unit := do 
  let input <- IO.FS.lines "a.in"
  let sol := addList (solveGame (input.map parse_input).toList)
  IO.println s!"{sol}"  

 