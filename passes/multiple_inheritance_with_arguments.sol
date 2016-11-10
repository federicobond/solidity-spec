contract foo {
  function foo(uint a) {
  }
}

contract bar {
    function bar(string a, string b) {
    }
}

contract derived is foo(2), bar("abc", "def") {
  function fun() {
  }
}
