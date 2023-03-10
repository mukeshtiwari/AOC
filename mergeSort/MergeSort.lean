import Init.Data.List


section MergeSort
  universe u 
  variable 
    {A : Type u}
    (f : A -> A -> Bool)

  
  def splitList : Nat -> List A -> List A × List A :=
    fun n xs => (List.take n xs, List.drop n xs)

  
  theorem take_decreasing : 
    forall (xs : List A) (n : Nat), 
    n < List.length xs -> 
    sizeOf (List.take n xs) < sizeOf xs := by 
    intro xs
    induction xs with 
    | nil => 
      focus
        intros n Ha 
        contradiction 
    | cons xh xhs ih => 
      focus
        intros n Ha 
        cases n with 
        | zero => 
          focus 
            unfold List.take 
            simp 
            simp at Ha 
            sorry 
            
        | succ n' =>
          focus
            unfold List.take 
            simp 
            simp at Ha 
            sorry 


    theorem drop_decreasing : 
      forall (xs : List A) (n : Nat), 
      0 < n -> 
      0 < List.length xs ->
      sizeOf (List.drop n xs) < sizeOf xs := by 
      intro xs
      induction xs with 
      | nil => 
        focus
          intros n Ha Hb 
          contradiction
      | cons xh xhs ih => 
        focus
          intros n Ha Hb 
          cases n with 
          | zero => 
            focus 
              contradiction
          | succ n' =>
            focus
              cases xhs with 
              | nil => 
                sorry 
              | cons yh yhs =>
                sorry 
                /-
                  requires transitivy of < 
                  I don't know how to 
                  simplify 
                -/


              

  theorem splitList_decreasing : 
    ∀ (n : Nat) (xs xsh ysh : List A), 
      0 < n -> 
      n < (List.length xs) -> 
      0 < List.length xs ->
      (xsh, ysh) = splitList n xs ->
      sizeOf xsh < sizeOf xs ∧ 
      sizeOf ysh < sizeOf xs := by 
    intros n xs xsh ysh Ha Hb Hc Hd 
    unfold splitList at Hd 
    sorry 
        



  def splitHalf : List A -> List A × List A :=
    fun xs => splitList (Nat.div (xs.length) 2) xs

  
  def mergeList : List A  -> List A -> List A  
  | [], ys => ys 
  | xs, [] => xs 
  | (xh :: xhs), (yh :: yhs) =>
    match f xh yh with 
    | true => xh :: mergeList xhs (yh :: yhs) 
    | false => yh :: mergeList (xh :: xhs) yhs
  termination_by mergeList xs ys => (xs, ys)
   

  def mergeSort : List A -> List A 
  | [] => []
  | [x] => [x]
  | (x₁ :: x₂ :: xs) => 
    match splitHalf (x₁ :: x₂ :: xs) with 
    | (xsh, ysh) => 
        have : sizeOf xsh < sizeOf (x₁ :: x₂ :: xs) := by 
          sorry 
        have : sizeOf ysh < sizeOf (x₁ :: x₂ :: xs) := by 
          sorry 
        mergeList f (mergeSort xsh) (mergeSort ysh)


  def go : A -> List A -> List A × List A 
  | _, [] => ([], [])
  | z, (x :: xs) => 
    match go z xs with 
    | (ys, zs) => 
      match f x z with 
      | true => (x :: ys, zs)
      | _ => (ys, x :: zs) 

  theorem go_decreasing : 
    ∀ (xs : List A) (z : A), 
    ¬(xs = [])  -> 
    match go f z xs with 
    | (ys, zs) => sizeOf zs < sizeOf xs := by 
    intro xs 
    induction xs with 
    | nil => 
      intros z Ha 
      contradiction
    | cons x xs ih => 
      intros z Ha
      unfold go 
      simp 
      cases (f x z) with 
      | true => 
        simp
        cases xs with 
        | nil => 
          unfold go 
          simp 
        | cons xt xsh =>
          unfold go
          simp 
          sorry 
      | false => sorry
      
      


  
  def groupBy : List A -> List (List A) 
  | [] => []
  | (x :: xs) => 
    match go f x (x :: xs) with 
    | (ys, zs) => 
      have : sizeOf zs < sizeOf (x :: xs) := by sorry 
      ys :: groupBy zs
  
 
end MergeSort

#eval groupBy (fun x y => x == y) [1, 1, 3, 4, 5]
#eval mergeSort (fun x y => x <= y)  [100, 200, 3, -1, 9, 8, 10, 1]
#eval mergeList (fun x y => x <= y) [8, 9, 10] [1, 2, 3] 