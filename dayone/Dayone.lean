


def apply_function : 
  (Nat -> Nat -> Nat) -> List Nat -> Nat := 
  λ (f : Nat -> Nat -> Nat) (xs : List Nat) =>
    List.foldr (λ x y => f x y) 0 xs 


def sum_list (xs : List Nat) : Nat := 
  apply_function (fun x y => x + y) xs

def max_list (xs : List Nat) : Nat :=
  apply_function max xs 


def solves : List (List Nat) → Int := 
  fun (xs : List (List Nat)) =>
    max_list (List.map sum_list xs)
