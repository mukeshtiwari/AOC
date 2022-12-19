import Init.Data.List


section MergeSort
  universe u 
  variable 
    {A : Type u}
    (f : A -> A -> Bool)

  
  def splitList : Nat -> List A -> List A × List A :=
    fun n xs => (List.take n xs, List.drop n xs)


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

 
end MergeSort

#eval mergeSort (fun x y => x <= y)  [9, 8, 10, 1]
#eval mergeList (fun x y => x <= y) [8, 9, 10] [1, 2, 3] 