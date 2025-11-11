use cardano/script_context.{ScriptContext}
use cardano/transaction.{OutputReference, Transaction}

validator peerswap {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    // If there is no stake part or the stake part is a script, we return True.
    // This is to avoid assets getting locked forever:

    // If the stake part is a key hash and the transaction is signed by that
    // key hash, we return True.
    // This means that the owner of the order (by definition the owner of the
    // stake key pair) can spend the UTxO without any restriction:

    // If the transaction is not signed by the owner, the actual swap logic has
    // to be fulfilled:
    False
  }

  else(_ctx: ScriptContext) {
    // This validator is only meant to be used for the spending purpose in
    // payment parts. Act as always succeeds otherwise (again to avoid forever
    // locked situations):
    True
  }
}
