contract foo {
  function fun() {
  }
}

contract bar {
  function fun() {
  }
}

contract derived is foo, bar {
  function fun() {
  }
}
