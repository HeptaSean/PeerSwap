use aiken/collection/list
use cardano/address.{Inline, Pointer, Script, VerificationKey}
use cardano/transaction.{OutputReference, Transaction}

validator peerswap {
  spend(
    datum: Option<Data>,
    redeemer: Data,
    utxo: OutputReference,
    self: Transaction,
  ) {
    // Find the input for which we validate:
    expect Some(own_input) =
      list.find(self.inputs, fn(input) { input.output_reference == utxo })
    when own_input.output.address.stake_credential is {
      // If there is no stake part, we return True if there is also no
      // reference script and False if there is a reference script.
      // This ensures that the reference script UTxO for this script itself
      // stays in the ledger while all other UTxOs created by accident can be
      // spent and are not locked forever:
      None ->
        when own_input.output.reference_script is {
          None -> True
          Some(_) -> False
        }

      // If the stake part is a pointer or a script, we return True.
      // These make no sense for our case and should also not be locked
      // forever:
      Some(Pointer { .. }) -> True
      Some(Inline(Script(_))) -> True

      Some(Inline(VerificationKey(owner_hash))) -> or {
          // If the stake part is a key hash and the transaction is signed by
          // that key hash, we return True.
          // This means that the owner of the order (by definition the owner of
          // the stake key pair) can spend the UTxO without any restriction:
          list.has(self.extra_signatories, owner_hash),
          // If the transaction is not signed by the owner, the actual swap
          // logic has to be fulfilled:
          False,
        }
    }
  }

  else(_) {
    // This validator is only meant to be used for the spending purpose in
    // payment parts. Act as always succeeds otherwise (again to avoid forever
    // locked situations):
    True
  }
}
