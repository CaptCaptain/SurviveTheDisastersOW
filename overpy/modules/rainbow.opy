#!define rSaturation 1.0
#!define rValue 1.0
#!define rMin (255 * (1-(rSaturation)) * (rValue))
#!define rMax (255 * (rValue))
#!define rMod ((rMax - rMin) * 6)
#!define rOffset (rMax - 2*rMin)

#!define rainbow(t) min(max(abs((((t) + (0*rMod)/3) % rMod) - rMod/2) - rOffset, rMin), rMax),\
                    min(max(abs((((t) + (1*rMod)/3) % rMod) - rMod/2) - rOffset, rMin), rMax),\
                    min(max(abs((((t) + (2*rMod)/3) % rMod) - rMod/2) - rOffset, rMin), rMax)