
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
Result 
-/
inductive Result : Type 
| Win | Lose | Tie


open MeMove OpponentMove Result 
def moveResult  (m : MeMove) (o : OpponentMove) : Result :=
match m, o with
| Xrock, Cscissors => Win 
| Xrock, Bpaper => Lose 
| Ypaper, Arock => Win 
| Ypaper, Cscissors => Lose 
| Zscissors, Bpaper => Win 
| Zscissors, Arock => Lose 
| _, _ => Tie 


def shapeValue : MeMove -> Nat 
| Xrock => 1 
| Ypaper => 2 
| Zscissors => 3

def resultScore : Result -> Nat 
| Win => 6
| Lose => 0 
| Tie => 3 


def computeScore : OpponentMove × MeMove -> Nat 
| (o, m) => resultScore (moveResult m o) + shapeValue m 


#eval (List.map computeScore 
  [(Arock, Ypaper), (Bpaper, Xrock), (Cscissors, Zscissors)])

 




