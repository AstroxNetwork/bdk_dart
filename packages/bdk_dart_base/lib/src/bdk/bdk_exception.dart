import 'package:freezed_annotation/freezed_annotation.dart';

part 'bdk_exception.freezed.dart';

@freezed
sealed class BdkException with _$BdkException {
  /// This error is thrown when trying to convert Bare and Public key script
  /// to address
  const factory BdkException.scriptDoesntHaveAddressForm() =
      BdkExceptionScriptDoesntHaveAddressForm;

  /// Cannot build a tx without recipients
  const factory BdkException.noRecipients() = BdkExceptionNoRecipients;

  /// Generic error
  const factory BdkException.generic(String e) = BdkExceptionGeneric;

  /// manuallySelectedOnly option is selected but no utxo has been passed
  const factory BdkException.noUtxosSelected() = BdkExceptionNoUtxosSelected;

  /// Output created is under the dust limit, 546 satoshis
  const factory BdkException.outputBelowDustLimit() =
      BdkExceptionOutputBelowDustLimit;

  /// Wallet’s UTXO set is not enough to cover recipient’s requested plus fee
  const factory BdkException.insufficientFunds(String e) =
      BdkExceptionInsufficientFunds;

  /// Branch and bound coin selection possible attempts with sufficiently
  /// big UTXO set could grow exponentially, thus a limit is set, and when hit,
  /// this error is thrown
  const factory BdkException.bnBTotalTriesExceeded() =
      BdkExceptionBnBTotalTriesExceeded;

  /// Branch and bound coin selection tries to avoid needing a change by finding
  /// the right inputs for the desired outputs plus fee, if there is not such
  /// combination this error is thrown
  const factory BdkException.bnBNoExactMatch() = BdkExceptionBnBNoExactMatch;

  /// Happens when trying to spend an UTXO that is not in the internal database
  const factory BdkException.unknownUtxo() = BdkExceptionUnknownUtxo;

  /// Thrown when a tx is not found in the internal database
  const factory BdkException.transactionNotFound() =
      BdkExceptionTransactionNotFound;

  /// Happens when trying to bump a transaction that is already confirmed
  const factory BdkException.transactionConfirmed() =
      BdkExceptionTransactionConfirmed;

  /// When bumping a tx the fee rate requested is lower than required
  const factory BdkException.feeRateTooLow(String e) =
      BdkExceptionFeeRateTooLow;

  /// When bumping a tx the absolute fee requested is lower than replaced tx
  /// absolute fee
  const factory BdkException.feeTooLow(String e) = BdkExceptionFeeTooLow;

  /// Node doesn’t have data to estimate a fee rate
  const factory BdkException.feeRateUnavailable() =
      BdkExceptionFeeRateUnavailable;

  /// Descriptor checksum mismatch
  const factory BdkException.checksumMismatch() = BdkExceptionChecksumMismatch;

  /// Miniscript error
  const factory BdkException.miniscript(String e) = BdkExceptionMiniscript;

  /// Miniscript error
  const factory BdkException.bip32(String e) = BdkExceptionBip32;

  /// An ECDSA error
  const factory BdkException.secp256k1(String e) = BdkExceptionSecp256k1;

  /// Sync attempt failed due to missing scripts in cache which are needed to
  /// satisfy stopGap.
  const factory BdkException.missingCachedScripts() =
      BdkExceptionMissingCachedScripts;

  /// Electrum client error
  const factory BdkException.electrum(String e) = BdkExceptionElectrum;

  /// Esplora client error
  const factory BdkException.esplora(String e) = BdkExceptionEsplora;

  /// Sled database error
  const factory BdkException.sled(String e) = BdkExceptionSled;

  /// Descriptor error
  const factory BdkException.descriptor(String e) = BdkExceptionDescriptor;

  /// Rpc client error
  const factory BdkException.rpc(String e) = BdkExceptionRpc;

  /// Rusqlite client error
  const factory BdkException.rusqlite(String e) = BdkExceptionRusqlite;

  /// Unknown error
  const factory BdkException.unexpected(String e) = BdkExceptionUnexpected;
}
