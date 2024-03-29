---
title: Rationalizing negative splits
topics: [economics, sports]
linkSource: yes
loadMathJax: yes
---

Many competitive runners aim for [negative splits](https://en.wikipedia.org/wiki/Negative_split): running the second half of a race faster than the first.
A more general goal is to speed up as the race progresses.
This post analyzes the conditions under which that goal makes sense.
I derive these conditions mathematically, demonstrate them with [an example](#a-simple-example), and discuss some possible [extensions](#extensions) to my analysis.

## When is speeding up optimal?

Suppose I want to run a unit distance as fast as possible.
I choose a speed function `\(s:[0,1]\to(0,\infty)\)` that minimizes my total running time
`$$\newcommand{\der}{\mathrm{d}}
\newcommand{\derfrac}[2]{\frac{\der #1}{\der #2}}
\newcommand{\parfrac}[2]{\frac{\partial #1}{\partial #2}}
T[s]:=\int_0^1\frac{1}{s(x)}\,\der x,$$`
where `\(x\)` indexes distance.[^discrete-time]
However, running uses energy, of which I have a limited supply `\(e(0)=1\)` at the start of my run and which evolves according to
`$$\parfrac{e(x)}{x}=-r(x,s(x),e(x)),$$`
where `\(r\)` determines the rate of energy consumption based on the instantaneous values of `\(x\)`, `\(s(x)\)`, and `\(e(x)\)`.
I assume that running faster uses more energy (i.e., `\(r\)` is increasing in `\(s(x)\)`) and that I use all of my energy (i.e, `\(e(1)=0\)`).

[^discrete-time]: I formalize my pacing problem as a "continuous-time" [optimal control problem](https://en.wikipedia.org/wiki/Optimal_control).
I consider a discrete-time version of this problem [here](/blog/optimal-pacing-varying-energy-costs/).

My interest is in how the shape of `\(s\)` depends on the shape of `\(r\)`.
In particular, I want to know what conditions I have to put on `\(r\)` to make `\(s\)` an increasing function of `\(x\)`.
I determine these conditions as follows.
First, I define the [Hamiltonian](https://en.wikipedia.org/wiki/Hamiltonian_%28control_theory%29)
`$$H(x,s(x),e(x),\lambda(x))\equiv-\frac{1}{s(x)}-\lambda(x)r(x,s(x),e(x)),$$`
where `\(\lambda\)` is a co-state function.
Under some regularity conditions, I can choose the optimizing functions point-wise, so for convenience I let `\(x\in[0,1]\)` be arbitrary and suppress functions' arguments.
Then `\(s\)` and `\(\lambda\)` satisfy the first-order conditions (FOCs)
`$$\begin{aligned}
0&=H_s=\frac{1}{s^2}-\lambda r_s \\
-\lambda_x&=H_e=-\lambda r_e,
\end{aligned}$$`
where subscripts denote (partial) differentiation.
Differentiating the first FOC with respect to `\(x\)` gives
`$$\frac{2s_x}{s^3}=-\lambda_xr_s-\lambda r_{sx},$$`
which, after substituting back in the two FOCs and dividing by `\(2\lambda r_s\)`, becomes
`$$\frac{s_x}{s}=-\frac{1}{2}\left(r_e+\frac{r_{sx}}{r_s}\right).$$`
Thus, if `\(s_x>0\)` then at least one of two conditions on `\(r\)` must hold:

1. `\(r_e<0\)`, which means that I use energy faster when I have less of it;
2. `\(r_{sx}/r_s<0\)`, which, coupled with the assumption that `\(r_s>0\)`, means that the energy cost of running fast falls as I cover more distance.

The intuition for the first condition is as follows:
energy falls with distance, and if it starts falling faster then I have to start running faster to avoid running out of energy before the finish line.
The second condition amplifies this motive to speed up by lowering the cost of running fast as the finish line approaches.
I don't know enough about physiology to know which condition is more plausible, but from experience I'm sympathetic to the second: I'm much less likely to [bonk](https://en.wikipedia.org/wiki/Hitting_the_wall) while running if I warm up slowly than if I sprint out of the gate.

## A simple example

Suppose I consume energy at the rate
`$$r(x,s(x),e(x))=(1-ax)s(x)$$`
for some parameter `\(a\in(0,1)\)`, which determines how the energy cost of running fast changes during my run.
That cost is approximately constant when `\(a\approx0\)` and becomes more decreasing in `\(x\)` as `\(a\)` approaches unity.
Given this definition of `\(r\)`, and given the boundary conditions `\(e(0)=1\)` and `\(e(1)=0\)`, the time-minimizing speed and energy profiles are
`$$s(x)=\frac{2\left(1-(1-a)^{3/2}\right)}{3a\sqrt{1-ax}}$$`
and
`$$e(x)=1-\frac{1-(1-ax)^{3/2}}{1-(1-a)^{3/2}}.$$`
Then `\(s\)` is an increasing function of `\(x\)` and becomes more convex as `\(a\)` rises.
It turns out that `\(T[s]=1\)` for all `\(a\in(0,1)\)`, so varying `\(a\)` preserves the mean speed `\(1/T[s]=1\)` but varies the curvature of `\(s\)` around that mean.
More generally, the time
`$$t(x)\equiv\int_0^x\frac{1}{s(y)}\,\der y$$`
taken to run distance `\(x\in[0,1]\)` satisfies `\(t(x)=1-e(x)\)`; that is, the proportion of time elapsed always equals the proportion of energy consumed.

The chart below plots `\(s(x)\)` and `\(t(x)\)` when `\(r=(1-ax)s(x)\)`.
When `\(a\approx0\)`, the energy cost of running fast is approximately constant with respect to distance and so the optimal speed profile is approximately flat.
As `\(a\)` increases, the cost of running fast increasingly falls with distance and so the optimal speed increasingly rises with distance.
Consequently, the percentage of time and energy spent on the first half of the run increases with `\(a\)`, starting at 50% when `\(a\approx0\)` and rising to 65% as `\(a\)` approaches unity.

![](figures/plot-1.svg)

## Extensions

One way to extend my analysis could be to [make the energy consumption rate stochastic](/blog/optimal-pacing-random-energy-costs/).
For example, if I run on unfamiliar terrain then I face uncertainty about upcoming obstacles (e.g., steep hills) and the energy cost of overcoming those obstacles.
This uncertainty would encourage me to start my run slowly as a form of [precautionary saving](https://en.wikipedia.org/wiki/Precautionary_savings), resulting in negative splits.

Another extension could be to model the different energy systems used when running at different speeds.
For example, short sprints use the anaerobic system, which burns carbohydrates for fuel, while long slow runs use the aerobic system, which also burns fat for fuel.
Adding more energy systems would allow for richer, more realistic dynamics, but would require more domain knowledge than I possess to set up the inter-dependencies correctly.

---

*Thanks to Logan Donald and Florian Fiaux for commenting on a draft version of this post.*

