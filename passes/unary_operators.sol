contract test {
    function f() {
        uint a = +10;
        a--;

        a = ~a;
        delete a;

        bool b = !true;
    }
}
