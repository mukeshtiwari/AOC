import Daytwo 



instance : ToString OpponentMove where
  toString : OpponentMove -> String 
  | OpponentMove.Arock => "A"
  | OpponentMove.Bpaper => "B"
  | OpponentMove.Cscissors => "C"

instance : ToString MeMove where
  toString : MeMove -> String 
  | MeMove.Xrock => "X"
  | MeMove.Ypaper => "Y"
  | MeMove.Zscissors => "Z"


def parse_input (c : String) : OpponentMove × MeMove :=
match c.trim.toList with 
| ['A', _, 'X'] => (OpponentMove.Arock, MeMove.Xrock)
| ['A', _, 'Y'] => (OpponentMove.Arock, MeMove.Ypaper)
| ['A', _, 'Z'] => (OpponentMove.Arock, MeMove.Zscissors)
| ['B', _, 'X'] => (OpponentMove.Bpaper, MeMove.Xrock)
| ['B', _, 'Y'] => (OpponentMove.Bpaper, MeMove.Ypaper)
| ['B', _, 'Z'] => (OpponentMove.Bpaper, MeMove.Zscissors)
| ['C', _, 'X'] => (OpponentMove.Cscissors, MeMove.Xrock)
| ['C', _, 'Y'] => (OpponentMove.Cscissors, MeMove.Ypaper)
| ['C', _, 'Z'] => (OpponentMove.Cscissors, MeMove.Zscissors)
/- Arbitrary -/
| _ => (OpponentMove.Cscissors, MeMove.Zscissors)


part one
def solveGame : List (OpponentMove × MeMove) -> List Nat :=
  fun xs => List.map computeScore xs 

def addList : List Nat -> Nat :=
  fun xs => List.foldl (fun x y => x + y) 0 xs 

def main : IO Unit := do 
  let input <- IO.FS.lines "a.in"
  let sol := addList (solveGame (input.map parse_input).toList)
  IO.println s!"{sol}"
