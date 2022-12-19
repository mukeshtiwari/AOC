import Lake
open Lake DSL

package daytwo {
  -- add package configuration options here
}

lean_lib Daytwo {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe daytwo {
  root := `Main
}
