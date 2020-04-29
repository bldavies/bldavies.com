---
title: Complicating the Monty Hall problem
topics: [games, probability]
loadMathJax: yes
---

The [Monty Hall problem](https://en.wikipedia.org/wiki/Monty_Hall_problem) posits a game show with three doors: one leading to a prize, and two leading to goats.
The show's host, Monty Hall, asks you to choose a door.
He then reveals a goat behind one of the unchosen doors and asks if you want to switch to the other unchosen door.

The optimal strategy in this scenario is to switch doors.
Suppose, without loss of generality, that you choose door 1.
Monty reveals a goat behind door `\(a\in\{2,3\}\)` and asks if you want to switch to door `\(b\in\{2,3\}\setminus\{a\}\)`.[^set-minus]
Door 1 leads to the prize with probability `\(1/3\)`, so the probability that either `\(a\)` or `\(b\)` lead to the prize is `\(2/3\)`.
When Monty reveals a goat behind door `\(a\)`, you learn that if the prize is behind door 2 or 3 then it must be behind door `\(b\)`.
Thus, switching from door 1 to door `\(b\)` doubles your probability of winning from `\(1/3\)` to `\(2/3\)`.

[^set-minus]: Here `\(B\setminus A\)` denotes the set of elements of `\(B\)` that are not elements of `\(A\)`.

[This week's Riddler Classic](https://fivethirtyeight.com/features/can-you-beat-the-goat-monty-hall-problem/) introduces a slightly more complicated version of the Monty Hall problem.
In this version, the total number of goats is uniformly distributed on `\(\{0,1,2,3\}\)`, goats are assigned to doors randomly such that every door leads to at most one goat, and doors not leading to goats all lead to prizes of equal value.
You choose a door, and if Monty can open a different door to reveal a goat then he does so; otherwise, he tells you there are no other doors that lead to goats.
If you choose door 1 and Monty reveals a goat behind one the unchosen doors, should you switch to the other unchosen door?

Again, the optimal strategy is to switch.
To see why, let `\(X_d\)` be the indicator variable for the event in which there is a goat behind door `\(d\)`.
Choosing a number of goats from `\(\{0,1,2,3\}\)` uniformly at random, and matching goats to doors randomly, is statistically equivalent to flipping a fair coin to determine whether each door leads to a goat.
Thus, the `\(X_d\)` are independently and identically distributed with
`$$\Pr(X_d=x)=\begin{cases}1/2 & \text{if}\ x\in\{0,1\}\\ 0 & \text{otherwise} \end{cases}$$`
for each `\(d\in\{1,2,3\}\)`.
Therefore, the probability of winning a prize if you stay with door 1 is `\(\Pr(X_1=0)=1/2\)`.
Now, let `\(Y={X_2+X_3}\)` count the number of goats behind doors 2 and 3.
Then `\(Y\)` has probability distribution
`$$\Pr(Y=y)=\begin{cases}\binom{2}{y}\left(\frac{1}{2}\right)^y\left(1-\frac{1}{2}\right)^{2-y} & \text{if}\ y\in\{0,1,2\}\\ 0 & \text{otherwise}, \end{cases}$$`
where the Binomial coefficient
`$$\binom{2}{y}=\frac{2!}{y!(2-y)!}$$`
counts the number of ways in which `\(y\)` goats can be distributed between doors 2 and 3.
When Monty reveals a goat behind an unchosen door, you learn that `\(Y>0\)`.
Thus, switching from door 1 to the remaining unchosen door wins you a prize with (conditional) probability
`$$\begin{align}
\Pr(Y=1\,\vert\,Y>0)
&= \frac{\Pr(Y=1\ \text{and}\ Y>0)}{\Pr(Y>0)} \\
&= \frac{\Pr(Y=1)}{1-\Pr(Y=0)} \\
&= \frac{\binom{2}{1}(1/2)^1(1-1/2)^1}{1-\binom{2}{0}(1/2)^0(1-1/2)^2} \\
&= \frac{1/2}{1-1/4} \\
&= \frac{2}{3},
\end{align}$$`
making you 33% more likely to win than if you don't switch.
