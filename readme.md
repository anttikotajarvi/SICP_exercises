
## Interpreters

### MIT 
https://www.gnu.org/software/mit-scheme/
> not available for windows

### Web
~~https://inst.eecs.berkeley.edu/~cs61a/fa14/assets/interpreter/scheme.html~~
> Behind a login-wall

The exercises are structured for running with `mit-scheme` but the Berkeleys web interpreter does have better explicit errors for example, in 1.5 evaluating the infinitely recursive `(p)` procedure with the MIT interpreter returns nothing and just halts, while the Berkeleys interpreter gives an actual procedure time out error.

#### Update 
From exercisese 1.12 onward: I have opted to use Racket with the SICP language pack to use the weird "subset" of Scheme used in the book, based on the fifth revision (R5RS)

[SICP lang](https://docs.racket-lang.org/sicp-manual/index.html)
