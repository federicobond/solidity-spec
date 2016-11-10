contract c {
    modifier mod(uint a) { if (msg.sender == a) _; }
};
