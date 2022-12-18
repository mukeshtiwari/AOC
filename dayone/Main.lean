import Init.System.IO 
import Dayone


def parse_input : List (Option Nat) -> List Nat 
| [] => []
| (x :: xs) => 
  match x with 
  | Option.none => []
  | Option.some v => (v :: parse_input xs)
  
partial
def parse_file : List (Option Nat) -> List (List Nat) :=
  fun xs => 
    match xs with 
    | [] => [] 
    | _ =>   
      match (List.takeWhile (fun x => x != Option.none) xs, 
        List.dropWhile (fun x => x != Option.none) xs) with 
      | (xsh, xst) => (parse_input xsh) :: 
        (match xst with 
        | [] => []
        | (y :: yst) => match y with 
          | Option.none => parse_file yst 
          | _ => parse_file xst)

def main : IO UInt32 := do
  let input ← IO.FS.lines "a.in"
  let sol := Array.insertionSort (List.map sum_list 
    (parse_file (input.toList.map String.toNat?))).toArray (.>=.)
  let ans := (sol.toList.take 3) 
  IO.println s!"{ans}"
  return 0
