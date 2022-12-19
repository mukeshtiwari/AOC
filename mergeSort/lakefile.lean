import Lake
open Lake DSL

package mergeSort {
  -- add package configuration options here
}

lean_lib MergeSort {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe mergeSort {
  root := `Main
}
