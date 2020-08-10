# LLVM Related Operations

## C -> LLVM (How to Produce IR in a Nice Form)

This was taken from [this talk](https://www.youtube.com/watch?v=J5xExRGaIIY&t=684s).

### Command Line
```
clang -O3 -XClang -disable-llvm-passes \
      -S -emit-llvm code.c -o code.ll && \
opt -S -mem2reg -instnamer code.ll -o code_after_opt.ll
```

### Explanation

#### Clang
This command line produces the IR:
* `clang` is the LLVM compiler driver.
* `O3` prepare for the `O3` pipeline (but don't actually run it).
* `XClang` pass the following argument (`-disable-llvm-passes`) to the clang compiler.
* `disable-llvm-passes` do not run any of the optimization passes (see `-XClang`).
* `S` produce IR as human readable assembly rather than bitcode.
* `emit-llvm` emit the IR.

#### Opt
This command line cleans up the IR a bit:
* `S` produce textual assembly IR again (rather than bitcode).
* `mem2reg` run the *mem2reg* pass. This is required since clang uses stack allocations
to bypass the need to follow SSA in the IR and avoid phi nodes between basic blocks.
This pass will premote all loads and stores which could potentially go in a register into
SSA form (i.e. if the address doesn't escape the function) see
[here](https://llvm.org/docs/Passes.html#mem2reg-promote-memory-to-register).
* `instnamer` By default all IR values will have numerical names, this pass will give
values in the IR more human readable names which is nicer to look at.
see [here](https://llvm.org/docs/Passes.html#instnamer-assign-names-to-anonymous-instructions).
