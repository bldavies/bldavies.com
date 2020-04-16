---
title: Optimal training loads
tags: [sports]
loadMathJax: yes
---

Suppose I'm training for an upcoming race.
I want to choose the training load that maximises my expected performance on race day.
The harder I train, the better my performance will be but the more likely I am to injure myself.
How should I balance this trade-off between better performance and greater risk of injury?

We can model this choice problem as follows.[^econ321]
Let `\(t\in[0,1]\)` represent my training load and `\(a\in\mathbb{R}\)` my natural ability.[^t-interpretation]
My performance on race day is some function `\(f(t,a)\)` of `\(t\)` and `\(a\)`.
I assume that this function is increasing and concave in `\(t\)` (so that there are positive but diminishing returns to training), and increasing in `\(a\)`.

[^econ321]: This model is based on one described in my [ECON321](https://www.canterbury.ac.nz/courseinfo/GetCourseDetails.aspx?course=ECON321&occurrence=15S1(C)&year=2015) lecture notes from 2015.

[^t-interpretation]: For example, `\(t\)` could represent the proportion of time before the race that I spend training.

I can't compete if I get injured, which occurs with some probability `\(p(t,r)\)` that depends on my training load and my natural resistance to injury `\(r\in\mathbb{R}\)`.
I assume that `\(p\)` is increasing and convex in `\(t\)` (so that training increases my likelihood of injury at an increasing rate), and decreasing in `\(r\)`.

My objective is to choose the training load `\(t^*\)` that maximises my expected performance[^continuity]
`$$\psi(t)=(1-p(t,r))\,f(t,a).$$`
My assumptions on the shapes of `\(f\)` and `\(p\)` imply that `\(\psi\)` is concave in `\(t\)`.
Therefore, the unique optimal training load `\(t^*\)` satisfies the first-order condition (FOC)
`$$\begin{align}
0
&= \psi'(t^*) \\
&= -p_t(t^*,r)\,f(t^*,a)+(1-p(t^*,r))\,f_t(t^*,a),
\end{align}$$`
where `\(\psi'\)` denotes the derivative of `\(\psi\)` with respect to `\(t\)`, and
where `\(p_t\)` and `\(f_t\)` denote the partial derivatives of `\(p\)` and `\(f\)` with respect to `\(t\)`.
The FOC can be rewritten as
`$$(1-p(t^*,r))\,f_t(t^*,a)=p_t(t^*,r)f(t^*,a),$$`
which shows that I should keep training until the marginal benefit of improved performance (the left-hand side) equals the marginal cost of injury becoming more probable (the right-hand side).

[^continuity]: I assume that `\(f\)` and `\(p\)` are twice continuously differentiable so that `\(\psi\)` is too.

I can't determine the value of `\(t^*\)` without further assumptions on `\(f\)` and `\(p\)`.
However, I can determine the relationship between `\(t^*\)` and the parameters `\(a\)` and `\(r\)`.
Since `\(\psi''(t)<0\)` for all feasible `\(t\)`, the [implicit function theorem](https://en.wikipedia.org/wiki/Implicit_function_theorem) (IFT) implies that
`$$\mathrm{sign}\frac{\partial t^*}{\partial \theta}=\mathrm{sign}\frac{\partial \psi'(t^*)}{\partial \theta}$$`
for each element `\(\theta\)` of the symbol set `\(\{a,r\}\)`.
Now
`$$\frac{\partial \psi'(t^*)}{\partial a}=-p_t(t^*,r)\,f_a(t^*,a)+(1-p(t^*,r))\,f_{ta}(t^*,a),$$`
where `\(f_a\)` and `\(f_{ta}\)` denote the partial derivatives of `\(f\)` and `\(f_t\)` with respect to `\(a\)`, and
`$$\frac{\partial \psi'(t^*)}{\partial r}=-p_{tr}(t^*,r)\,f(t^*,a)-p_r(t^*,r)\,f_t(t^*,a),$$`
where `\(p_{tr}\)` and `\(p_r\)` denote the partial derivatives of `\(p_t\)` and `\(p\)` with respect to `\(r\)`.
By [Young's theorem](https://en.wikipedia.org/wiki/Symmetry_of_second_derivatives), the mixed partials `\(f_{ta}\)` and `\(p_{tr}\)` satisfy
`$$f_{ta}(t,a)=\frac{\partial}{\partial t}\left(\frac{\partial f(t,a)}{\partial a}\right)$$`
and
`$$p_{tr}(t,r)=\frac{\partial}{\partial t}\left(\frac{\partial p(t,r)}{\partial r}\right)$$`
for all feasible `\(t\)`, `\(a\)` and `\(r\)`.
Thus, it seems reasonable to assume that `\(f_{ta}(t,a)\le0\)` and `\(p_{tr}(t,r)\le0\)`, which mean that training washes out the benefits of natural ability and resistance to injury.
These assumptions, together with the IFT, imply that `\(t^*\)` is decreasing in `\(a\)` and increasing in `\(r\)`---that is, I should train harder if I become less naturally able or more resistant to injury.
