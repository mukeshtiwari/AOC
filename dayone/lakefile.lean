import Lake
open Lake DSL

package dayone {
  -- add package configuration options here
}

lean_lib Dayone {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe dayone {
  root := `Main
}
