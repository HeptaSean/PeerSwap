PeerSwap
========
Cardano smart contract for self-custodial swaps

Motivation
----------
One of the original ideas of cryptocurrencies was to get rid of unnecessary
intermediates in financial applications, to get rid of “middlemen” who could
block transactions, enforce unreasonable rules, or take too high fees for
themselves.

But crypto ecosystems turned out to have a lot of *new* intermediates.
Trading is prdominantly done on decentralised exchanges (DEXes) which –
despite the name – are mostly controlled by centrally by their operators, set
their own rules, and take (often quite high) fees and siphon them out to their
operators and token holders.

So, let's cut away the DEXes!
They are “middlemen”, too!

With Cardano's smart contracts, it is possibe that users publish their
offers/orders to unspent transaction outputs (UTxOs) that are still completely
controlled by them.
The collection of all these offers/orders then constitutes a huge, truly
decentralised orderbook.
The Cardano chain itself, in a way, *is* the orderbook.

Other users then can (partially) fill such an order by just interacting with
the contract UTxO, taking some of the offered assets and putting the requested
amount of the requested assets into a new UTxO still belonging to the original
offerer.

If matching offers exist on the chain, a third party could profit from
arbitrage by interacting with matching orders on the chain and taking the
difference for themselves.
This can also be done in a triangular way if there are offers trading asset A
for asset B, asset B for asset C, and asset C for asset A with an arbitrage
opportunity if you look at all three of them.

Frontend providers could take small fees for offering interfaces to this
system, but are limited by the fact that everyone can just run their own tools
if the service seems to expensive.
Frontends could be implemented directly in wallet apps, which are in a
particularly good position to execute matching orders before they even hit the
chain.

Related work to this is @fallen-icarus'
[Cardano-Swaps](https://github.com/fallen-icarus/cardano-swaps) where our
system is designed from scratch and tries to be as minimal as poosible, even
simpler than Cardano-Swaps.

The goal is that almost every user of the system can read the contracts
themselves to verify that it does what they want it to do.

Aiken Contract
--------------

Example Transactions
--------------------
