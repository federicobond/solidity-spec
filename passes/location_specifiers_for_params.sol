contract Foo {
    function f(uint[] memory x) { }
    function f(uint[] storage x) internal { }
}
