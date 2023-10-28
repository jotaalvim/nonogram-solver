from z3 import *


# https://www.researchgate.net/figure/a-shows-an-example-of-a-Nonogram-Its-solution-is-shown-in-b-The-description-for_fig3_228862924

n = 6
rows = [ [2,1],[1,3],[1,2],[3],[4],[1] ]
collumns = [ [1],[5],[2],[5],[2,1],[2] ]

x = {}
for p in range(n):
    x[p] = {}
    for g in range(n):
        x[p][g] = Bool("%s,%d" % (p,g))

print(x)

s = Solver()


# um quadrado está branco ou preto
for i in range(n):
    for j in range(n):
        s.add( Or(x[i][j], Not(x[i][j] ) )  )
        

#for p in pessoas:
#  s.add(Or([x[p][g] for g in gabs]))
#
## Cada pessoa ocupa no máximo um gabinete.
##for p in pessoas:
##  s.add(Implies(x[p][1], And(Not(x[p][2]),Not(x[p][3])) ))
##  s.add(Implies(x[p][2],Not(x[p][3])))
#for p in pessoas:
#    for g in gabs:
#        s.add(Implies( x[p][g], [ Not(x[p][h]) for h in range(g+1,4) ] ))
#
#
## O Nuno e o Pedro não podem partilhar gabinete.





if s.check() == sat:
    m = s.model()
    for p in range(n) :
        for g in range(n):
            if is_true(m[x[p][g]]):
                print("%s fica no gabinete %s" % (p,g))
else:
  print("Não tem solução.")

