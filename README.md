Solidity Spec Suite
===================

This suite has been extracted mostly from the official Solidity compiler tests
and contains a list of `.sol` files that should either pass or fail in any
compliant solidity parser. It does not attempt to be complete or extensive at
this point, just a starting point for Solidity parser authors.

There is a test runner at `./run-tests.sh`. To test your parser against it, run:

```
./run-tests.sh -p ../path/to/your/parser/executable
```

Your parser should exit with status 0 if it parsed the input successfully or >0
otherwhise. The output from each test is collected in `output/` so you can
analyze it later.

The tool will run all test examples by default and report accordingly.

If you are working on getting a specific test to pass, you can run the script
with the `-f <glob>` option to filter the tests by a certain pattern. For
example:

```
./run-tests.sh -p myparser -f "*enum*"
```

## License

Code is licensed under the GPL.

## Author

The Solidity Spec Suite is developed by [Federico Bond](https://github.com/federicobond)
