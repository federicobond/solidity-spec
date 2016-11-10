contract test {
    function fun(uint256 a) {
        uint256 x = ([1, 2, 3 + 4][a/=9] - 3) ** 4;
    }
}
