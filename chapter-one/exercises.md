# CHAPTER1
 λ
## Equivalence Exercises

1. λxy.xz - answer: b - λmn.mz
2. λxy.xxy - answer: c - λa(λb.aab)
3. λxyz.zx - answer: b - λtos.st

## Chapter excercises

### Combinatorsλ

1. λx.xxx - True
2. λxy.xz - False
3. λxyz.xy(zx) - True
4. λxyz.xy(zxy) - True
5. λxy.xy(zxy) - False

### Normal form or divergeλ

1. λx.xxx - Normal
2. (λz.zz)(λy.yy) - Diverge
3. (λx.xxx)z - Normal

### Beta reduce

1. (λabc.cba)zz(λwv.w)
   - (λa.λb.λc.cba)(z)z(λw.λv.w)
   - (λb.λc.cbz)(z)(λw.λv.w)
   - (λc.czz)(λw.λv.w)
   - λw.λv.(w)(z)(z)
   - λv.(z)z
   - z
2. (λx.λy.xyy)(λa.a)b
   - (λy.λa.ayy)b
   - λa.abb
   - bb
3. (λy.y)(λx.xx)(λz.zq)
   - (λx.xx)(λz.zq)
   - (λz.zq)(λz.zq)
   - (λz.zq)q
   - qq
4. (λz.z)(λz.zz)(λz.zy)
   - (λz.zz)(λz.zy)
   - (λz.zy)(λz.zy)
   - (λz.zy)(y)
   - yy
5. (λx.λy.xyy)(λy.y)y
   - (λy.(λy.y)yy)y
   - (λy.y)yy
   - yy
6. (λa.aa)(λb.ba)c
   - (λb.ba)(λb.ba)c
   - (λb.ba)(a)c
   - aac
7. (λxyz.xz(yz))(λx.z)(λx.a)
   - (λx.λy.λz.xz(yz))(λx.z)(λx.a)
   - (λy.λz1.(λx.z)z1(yz1))(λx.a)
   - (λz1.z((λx.a)(z1))
   - (λz1.z((λx.a)(z1))
   - (λz1.za)
