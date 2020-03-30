---
title: Spotify Premium pricing
tags: [microeconomics, Spotify]
loadMathJax: yes
---

[Spotify](https://www.spotify.com/) offers two music and podcast streaming services:
a free, online-only service, and
a paid "Premium" service with extra features like unlimited skips and offline playback.
Spotify earns some revenue from serving ads to free users, but most of its revenue ([about 88% in 2019Q4](https://investors.spotify.com/financials/default.aspx)) comes from Premium subscriptions.
This revenue needs to cover Spotify's fixed and variable costs, which include the costs of maintaining its servers and of paying royalties for streaming artists' music.

Spotify's profit function looks something like
`$$\pi(p)=n\theta(p)(p-v_1)+n(1-\theta(p))(a-v_2)-f,$$`
where `\(p\)` is the price of subscribing to Spotify Premium, `\(n\)` is the number of Spotify users, `\(\theta(p)\)` is the price-dependent proportion of these users who pay for Premium, `\(a\)` is the revenue from serving ads to each free user, `\(v_1\)` and `\(v_2\)` are Spotify's variable costs per Premium and free user, and `\(f\)` is Spotify's fixed costs.
I assume that `\(\theta(p)\)` decreases with `\(p\)` so that Spotify Premium is an [ordinary good](https://en.wikipedia.org/wiki/Ordinary_good).

The profit-maximising price `\(p^*\)` satisfies the first-order condition (FOC)
`$$\begin{align}
0
&= \pi'(p^*) \\
&= n\theta'(p^*)(p^*-v_1)+n\theta(p^*)-n\theta'(p^*)(a-v_2),
\end{align}$$`
where `\(\pi'\)` and `\(\theta'\)` denote the derivatives of `\(\pi\)` and `\(\theta\)` with respect to `\(p\)`.
If `\(a=0\)` and `\(v_1=v_2\)` then the FOC can be rewritten as
`$$\frac{p^*\theta'(p^*)}{\theta(p^*)}=-1,$$`
which means that, at `\(p=p^*\)`, the demand for Spotify Premium is unit elastic with respect to its price.
If free users generate no ad revenue and have the same variable costs per user as Premium subscribers, then Spotify should raise its Premium price until the increased revenue per Premium subscriber exactly offsets the decrease in such subscribers.
In contrast, if `\(a>0\)` or if `\(v_1>v_2\)` then Spotify must raise `\(p^*\)` further to decrease `\(\theta(p^*)\)` and avoid the lost ad revenue or increased variable costs from converting too many free users.

Notice that `\(\pi'(p^*)\)` is constant in `\(n\)`, so `\(p^*\)` does not change when `\(n\)` changes.
In contrast, assuming that the second derivative of `\(\pi\)` with respect to `\(p\)` is negative at `\(p^*\)` (so that `\(p^*\)` is profit-*maximising* rather than profit-*minimising*), the [implicit function theorem](https://en.wikipedia.org/wiki/Implicit_function_theorem) implies that
`$$\frac{\partial p^*}{\partial a}=\frac{\partial p^*}{\partial v_1}>0>\frac{\partial p^*}{\partial v_2}.$$`
In words, the profit-maximising price is increasing in `\(a\)` and `\(v_1\)`, and decreasing in `\(v_2\)`.
Intuitively, if Spotify collects more ad revenue from free users then it can afford to lose some Premium subscribers by raising the Premium price.
Likewise, the greater is the difference between `\(v_1\)` and `\(v_2\)`, the more expensive it is to serve Premium subscribers relative to free users and so the fewer Premium subscriptions Spotify would prefer to sell.
