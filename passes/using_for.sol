library Lib {
}

contract C {
    struct s { uint a; }
    using Lib for uint;
    using Lib for *;
    using Lib for s;

    function f() {
    }
}
