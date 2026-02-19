### issue 2026-02-18

```
$ gfortran fit_dstark_t.f -o fit.exe $(cernlib packlib)
$ ./fit.exe
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals   0.00000000       0.00000000       0.00000000       0.00000000

Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
```

Try finding problem code, see also:
* https://gcc.gnu.org/onlinedocs/gfortran/Option-Summary.html
```
$ gfortran --std=legacy -g -O0 -fcheck=all -fbacktrace fit_dstark_t.f -o fit.exe $(cernlib packlib)
$ ./fit.exe
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals   0.00000000       0.00000000       0.00000000       0.00000000
At line 71 of file fit_dstark_t.f
Fortran runtime error: Index '-250069568' of dimension 1 of array 'hx1' below lower bound of 1
```

Solution `-fno-automatic` option, see also:
* https://gcc.gnu.org/onlinedocs/gfortran/Code-Gen-Options.html
* https://gcc.gnu.org/onlinedocs/gfortran/AUTOMATIC-and-STATIC-attributes.html
```
$ gfortran --std=legacy -g -O0 -fno-automatic -fcheck=all -fbacktrace fit_dstark_t.f -o fit.exe $(cernlib packlib)
# or simple without "debugging"
$ gfortran --std=legacy -fno-automatic fit_dstark_t.f -o fit.exe $(cernlib packlib)
$ ./fit.exe
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750
 integrals  0.368924201       574.851318       216.618103       205.593750


 integrals  0.405458361       574.851318       350.177826       301.544037
 integrals  0.405458361       574.851318       336.794830       301.544037
 integrals  0.405458361       574.851318       349.292664       302.136627
 resonance           1   365.317596
 resonance           2   212.638016
 resonance           3   195.913376

```
