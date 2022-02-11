
### Expansion



function expansion() {

  function getSomething() {
    echo "something"
  }
  echo ~
  echo src/expansion/dir/*

  local var1=1
  echo $var1

  #arithmetic
  echo $((1 + 1))

  #brace
  echo {1,2,3}

  #command
  echo $(getSomething)
}




