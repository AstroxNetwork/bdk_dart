use crate::bdk::psbt::Transaction;

use bdk_lite::{Balance as BdkBalance, Error as BdkError};
use bdk_lite::wallet::tx_builder::ForeignUtxo as BdkForeignUtxo;
use bdk_lite::wallet::tx_builder::TxOutForeign as BdkTxOutForeign;
use bitcoin::{
    hashes::hex::FromHex, hashes::hex::ToHex, locktime::Error,
    Address as BdkAddress, AddressType as BdkAddressType, OutPoint as BdkOutPoint,
    Script as BitcoinScript, Txid,
};
use bitcoin::blockdata::transaction::{
    TxIn as BdkTxIn, TxOut as BdkTxOut,
};
use bitcoin::util::address::{
    Payload as BdkPayload, WitnessVersion as BdkWitnessVersion,
};
use serde::{Deserialize, Serialize};
use std::borrow::Borrow;
use std::fmt::Debug;
use std::str::FromStr;

#[derive(Debug, Clone)]
pub struct TxIn {
    pub previous_output: OutPoint,
    pub script_sig: Script,
    pub sequence: u32,
    pub witness: Vec<String>,
}
impl From<&BdkTxIn> for TxIn {
    fn from(x: &BdkTxIn) -> Self {
        TxIn {
            previous_output: x.previous_output.into(),
            script_sig: x.clone().script_sig.into(),
            sequence: x.clone().sequence.0,
            witness: x.witness.to_vec().iter().map(|x| x.to_hex()).collect(),
        }
    }
}

/// A transaction output, which defines new coins to be created from old ones.
pub struct TxOut {
    /// The value of the output, in satoshis.
    pub value: u64,
    /// The address of the output.
    pub script_pubkey: Script,
}
impl From<&BdkTxOut> for TxOut {
    fn from(x: &BdkTxOut) -> Self {
        TxOut {
            value: x.clone().value,
            script_pubkey: x.clone().script_pubkey.into(),
        }
    }
}

/// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub(crate) txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub(crate) vout: u32,
}
impl From<&OutPoint> for BdkOutPoint {
    fn from(x: &OutPoint) -> BdkOutPoint {
        BdkOutPoint {
            txid: Txid::from_str(x.clone().txid.borrow()).unwrap(),
            vout: x.clone().vout,
        }
    }
}
impl From<BdkOutPoint> for OutPoint {
    fn from(x: BdkOutPoint) -> OutPoint {
        OutPoint {
            txid: x.txid.to_string(),
            vout: x.clone().vout,
        }
    }
}

#[derive(Debug, Clone)]
pub struct ForeignUtxo {
    /// Reference to a transaction output
    pub outpoint: OutPoint,
    ///Transaction output
    pub txout: TxOutForeign,
}
impl From<&ForeignUtxo> for BdkForeignUtxo {
    fn from(x: &ForeignUtxo) -> BdkForeignUtxo {
        BdkForeignUtxo {
            outpoint: BdkOutPoint {
                txid: Txid::from_str(x.outpoint.txid.borrow()).unwrap(),
                vout: x.outpoint.vout.clone(),
            },
            txout: BdkTxOutForeign {
                value: x.txout.value.clone(),
                script_pubkey: x.txout.script_pubkey.clone(),
            },
        }
    }
}
impl From<BdkForeignUtxo> for ForeignUtxo {
    fn from(x: BdkForeignUtxo) -> ForeignUtxo {
        ForeignUtxo {
            outpoint: OutPoint::from(x.outpoint),
            txout: TxOutForeign {
                value: x.txout.value,
                script_pubkey: x.txout.script_pubkey,
            },
        }
    }
}

/// TxBytes with tx_id and bytes
#[derive(Debug, Clone)]
pub struct TxBytes {
    /// The value of the output, in satoshis.
    pub tx_id: String,
    /// The script which must be satisfied for the output to be spent.
    pub bytes: Vec<u8>,
}
impl TxBytes {
    pub fn to_transaction(&self) -> Result<Transaction, bdk_lite::Error> {
        Transaction::new(self.bytes.clone())
    }
}

#[derive(Debug, Clone)]
pub struct TxOutForeign {
    /// The value of the output, in satoshis.
    pub value: u64,
    /// The script which must be satisfied for the output to be spent.
    pub script_pubkey: String,
}

/// Local Wallet's Balance
#[derive(Deserialize)]
pub struct Balance {
    // All coinbase outputs not yet matured
    pub immature: u64,
    /// Unconfirmed UTXOs generated by a wallet tx
    pub trusted_pending: u64,
    /// Unconfirmed UTXOs received from an external wallet
    pub untrusted_pending: u64,
    /// Confirmed and immediately spendable balance
    pub confirmed: u64,
    /// Get sum of trusted_pending and confirmed coins
    pub spendable: u64,
    /// Get the whole balance visible to the wallet
    pub total: u64,
}
impl From<BdkBalance> for Balance {
    fn from(bdk_balance: BdkBalance) -> Self {
        Balance {
            immature: bdk_balance.immature,
            trusted_pending: bdk_balance.trusted_pending,
            untrusted_pending: bdk_balance.untrusted_pending,
            confirmed: bdk_balance.confirmed,
            spendable: bdk_balance.get_spendable(),
            total: bdk_balance.get_total(),
        }
    }
}

/// The address index selection strategy to use to derived an address from the wallet's external
/// descriptor.
pub enum AddressIndex {
    /// Return a new address after incrementing the current descriptor index.
    NewIndex,
    /// Return the address for the current descriptor index if it has not been used
    /// in a received transaction. Otherwise, return a new address as with AddressIndex.NewIndex.
    /// Use with caution, if the wallet has not yet detected an address has been used
    /// it could return an already used address. This function is primarily meant for situations
    /// where the caller is untrusted; for example when deriving donation addresses on-demand
    /// for a public web page.
    LastUnused,
    /// Return the address for a specific descriptor index. Does not change the current descriptor
    /// index used by `AddressIndex` and `AddressIndex.LastUsed`.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address may have already been used.
    Peek { index: u32 },
    /// Return the address for a specific descriptor index and reset the current descriptor index
    /// used by `AddressIndex` and `AddressIndex.LastUsed` to this value.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address and subsequent addresses returned by calls to `AddressIndex`
    /// and `AddressIndex.LastUsed` may have already been used. Also if the index is reset to a
    /// value earlier than the Blockchain stopGap (default is 20) then a
    /// larger stopGap should be used to monitor for all possibly used addresses.
    Reset { index: u32 },
}
impl From<AddressIndex> for bdk_lite::wallet::AddressIndex {
    fn from(x: AddressIndex) -> bdk_lite::wallet::AddressIndex {
        match x {
            AddressIndex::NewIndex => bdk_lite::wallet::AddressIndex::NewIndex,
            AddressIndex::LastUnused => bdk_lite::wallet::AddressIndex::LastUnused,
            AddressIndex::Peek { index } => bdk_lite::wallet::AddressIndex::Peek(index),
            AddressIndex::Reset { index } => bdk_lite::wallet::AddressIndex::Reset(index),
        }
    }
}

/// A derived address and the index it was found at for convenience this automatically
/// derefs to [Address].
pub struct AddressInfo {
    ///Child index of this address
    pub index: u32,
    /// Address
    pub address: String,
}
impl From<bdk_lite::wallet::AddressInfo> for AddressInfo {
    fn from(x: bdk_lite::wallet::AddressInfo) -> AddressInfo {
        AddressInfo {
            index: x.index,
            address: x.address.to_string(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Default, Serialize)]
/// A wallet transaction
pub struct TransactionDetails {
    pub serialized_tx: Option<String>,
    /// Transaction id.
    pub txid: String,
    /// Received value (sats)
    /// Sum of owned outputs of this transaction.
    pub received: u64,
    /// Sent value (sats)
    /// Sum of owned inputs of this transaction.
    pub sent: u64,
    /// Fee value (sats) if confirmed.
    /// The availability of the fee depends on the backend. It's never None with an Electrum
    /// Server backend, but it could be None with a Bitcoin RPC node without txindex that receive
    /// funds while offline.
    pub fee: Option<u64>,
    /// If the transaction is confirmed, contains height and timestamp of the block containing the
    /// transaction, unconfirmed transaction contains `None`.
    pub confirmation_time: Option<BlockTime>,
}
/// A wallet transaction
impl From<&bdk_lite::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk_lite::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            serialized_tx: x
                .clone()
                .transaction
                .map(|x| Transaction { internal: x }.into()),
            fee: x.clone().fee,
            txid: x.clone().txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
            confirmation_time: set_block_time(x.confirmation_time.clone()),
        }
    }
}

fn set_block_time(time: Option<bdk_lite::BlockTime>) -> Option<BlockTime> {
    if let Some(time) = time {
        Some(time.into())
    } else {
        None
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
///Block height and timestamp of a block
pub struct BlockTime {
    ///Confirmation block height
    pub height: u32,
    ///Confirmation block timestamp
    pub timestamp: u64,
}

impl From<bdk_lite::BlockTime> for BlockTime {
    fn from(x: bdk_lite::BlockTime) -> Self {
        BlockTime {
            height: x.height,
            timestamp: x.timestamp,
        }
    }
}

/// A output script and an amount of satoshis.
pub struct ScriptAmount {
    pub script: Script,
    pub amount: u64,
}

#[allow(dead_code)]
#[derive(Clone, Debug)]
pub enum RbfValue {
    RbfDefault,
    Value(u32),
}

/// The result after calling the TxBuilder finish() function. Contains unsigned PSBT and
/// transaction details.
pub struct BdkTxBuilderResult(pub String, pub TransactionDetails);

/// Types of keychains
pub enum KeychainKind {
    Extern,

    /// Internal, usually used for change outputs
    Intern,
}
impl From<bdk_lite::KeychainKind> for KeychainKind {
    fn from(e: bdk_lite::KeychainKind) -> Self {
        match e {
            bdk_lite::KeychainKind::External => KeychainKind::Extern,
            bdk_lite::KeychainKind::Internal => KeychainKind::Intern,
        }
    }
}
impl From<KeychainKind> for bdk_lite::KeychainKind {
    fn from(kind: KeychainKind) -> Self {
        match kind {
            KeychainKind::Extern => bdk_lite::KeychainKind::External,
            KeychainKind::Intern => bdk_lite::KeychainKind::Internal,
        }
    }
}

#[derive(Clone)]
/// The cryptocurrency to act on
pub enum Network {
    /// Bitcoin’s testnet
    Testnet,
    /// Bitcoin’s regtest
    Regtest,
    /// Classic Bitcoin
    Bitcoin,
    /// Bitcoin’s signet
    Signet,
}
impl Default for Network {
    fn default() -> Self {
        Network::Testnet
    }
}
impl From<Network> for bitcoin::Network {
    fn from(network: Network) -> Self {
        match network {
            Network::Signet => bitcoin::Network::Signet,
            Network::Testnet => bitcoin::Network::Testnet,
            Network::Regtest => bitcoin::Network::Regtest,
            Network::Bitcoin => bitcoin::Network::Bitcoin,
        }
    }
}
impl From<bitcoin::Network> for Network {
    fn from(network: bitcoin::Network) -> Self {
        match network {
            bitcoin::Network::Signet => Network::Signet,
            bitcoin::Network::Testnet => Network::Testnet,
            bitcoin::Network::Regtest => Network::Regtest,
            bitcoin::Network::Bitcoin => Network::Bitcoin,
        }
    }
}

#[derive(Clone)]
///The address type mapping
pub enum AddressType {
    ///P2PKH
    P2PKH,
    ///P2SH
    P2SH,
    ///P2WPKH
    P2WPKH,
    ///P2WSH
    P2WSH,
    ///P2TR
    P2TR,
    P2PKHTR,
    ///
    Unknown,
}
impl From<BdkAddressType> for AddressType {
    fn from(address_type: BdkAddressType) -> Self {
        match address_type {
            BdkAddressType::P2pkh => AddressType::P2PKH,
            BdkAddressType::P2sh => AddressType::P2SH,
            BdkAddressType::P2wpkh => AddressType::P2WPKH,
            BdkAddressType::P2wsh => AddressType::P2WSH,
            BdkAddressType::P2tr => AddressType::P2TR,
            _ => AddressType::Unknown,
        }
    }
}
impl From<String> for AddressType {
    fn from(address_type_string: String) -> Self {
        match address_type_string.to_lowercase().as_str() {
            "p2pkh" => AddressType::P2PKH,
            "p2sh" => AddressType::P2SH,
            "p2sh_p2wpkh" => AddressType::P2SH,
            "p2wpkh" => AddressType::P2WPKH,
            "p2wsh" => AddressType::P2WSH,
            "p2tr" => AddressType::P2TR,
            "p2pkhtr" => AddressType::P2PKHTR,
            _ => AddressType::Unknown,
        }
    }
}
impl AddressType {
    pub fn to_string(&self) -> Result<String, BdkError> {
        match self {
            AddressType::P2PKH => Ok("p2pkh".to_string()),
            AddressType::P2SH => Ok("p2sh".to_string()),
            AddressType::P2WPKH => Ok("p2wpkh".to_string()),
            AddressType::P2WSH => Ok("p2wsh".to_string()),
            AddressType::P2TR => Ok("p2tr".to_string()),
            AddressType::P2PKHTR => Ok("p2pkhtr".to_string()),
            AddressType::Unknown => Err(BdkError::Generic("Unknown address type".to_string())),
        }
    }
}

///Type describing entropy length (aka word count) in the mnemonic
pub enum WordCount {
    ///12 words mnemonic (128 bits entropy)
    Words12,
    ///18 words mnemonic (192 bits entropy)
    Words18,
    ///24 words mnemonic (256 bits entropy)
    Words24,
}
impl From<WordCount> for bdk_lite::keys::bip39::WordCount {
    fn from(word_count: WordCount) -> Self {
        match word_count {
            WordCount::Words12 => bdk_lite::keys::bip39::WordCount::Words12,
            WordCount::Words18 => bdk_lite::keys::bip39::WordCount::Words18,
            WordCount::Words24 => bdk_lite::keys::bip39::WordCount::Words24,
        }
    }
}

pub struct Address {
    pub address: BdkAddress,
}
impl Address {
    pub fn new(address: String) -> Result<Self, BdkError> {
        BdkAddress::from_str(address.as_str())
            .map(|a| Address { address: a })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }

    pub fn get_address_type(address: String) -> Result<String, BdkError> {
        BdkAddress::from_str(address.as_str())
            .map(|a| Address { address: a }.address_type().unwrap().to_string())
            .map_err(|e| BdkError::Generic(e.to_string()))
    }

    pub fn address_type(&self) -> Result<String, BdkError> {
        match self.address.address_type() {
            None => Err(BdkError::Generic("Unknown Address Type".to_string())),
            Some(r) => match AddressType::from(r).to_string() {
                Ok(s) => Ok(s),
                Err(e) => Err(BdkError::Generic(e.to_string())),
            },
        }
    }

    pub fn from_script(script: Script, network: Network) -> Result<Self, BdkError> {
        BdkAddress::from_script(&script.into(), network.into())
            .map(|a| Address { address: a })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }
    pub fn payload(&self) -> Payload {
        match &self.address.payload.clone() {
            BdkPayload::PubkeyHash(pubkey_hash) => Payload::PubkeyHash {
                pubkey_hash: pubkey_hash.to_vec(),
            },
            BdkPayload::ScriptHash(script_hash) => Payload::ScriptHash {
                script_hash: script_hash.to_vec(),
            },
            BdkPayload::WitnessProgram { version, program } => Payload::WitnessProgram {
                version: version.to_owned().into(),
                program: program.clone(),
            },
        }
    }

    pub fn network(&self) -> Network {
        self.address.network.into()
    }

    pub fn script_pubkey(&self) -> BitcoinScript {
        self.address.script_pubkey()
    }
}

/// A Bitcoin script.
#[derive(Clone, Default, Debug)]
pub struct Script {
    pub internal: Vec<u8>,
}
impl Script {
    pub fn new(raw_output_script: Vec<u8>) -> Result<Script, Error> {
        let script = BitcoinScript::from_hex(&hex::encode(raw_output_script))
            .expect("Invalid script");
        Ok(Script {
            internal: script.into_bytes(),
        })
    }
}
impl From<Script> for BitcoinScript {
    fn from(value: Script) -> Self {
        BitcoinScript::from_hex(&hex::encode(value.internal)).expect("Invalid script")
    }
}
impl From<BitcoinScript> for Script {
    fn from(value: BitcoinScript) -> Self {
        Script {
            internal: value.into_bytes(),
        }
    }
}

#[derive(Debug, Clone)]
pub enum WitnessVersion {
    /// Initial version of witness program. Used for P2WPKH and P2WPK outputs
    V0 = 0,
    /// Version of witness program used for Taproot P2TR outputs.
    V1 = 1,
    /// Future (unsupported) version of witness program.
    V2 = 2,
    /// Future (unsupported) version of witness program.
    V3 = 3,
    /// Future (unsupported) version of witness program.
    V4 = 4,
    /// Future (unsupported) version of witness program.
    V5 = 5,
    /// Future (unsupported) version of witness program.
    V6 = 6,
    /// Future (unsupported) version of witness program.
    V7 = 7,
    /// Future (unsupported) version of witness program.
    V8 = 8,
    /// Future (unsupported) version of witness program.
    V9 = 9,
    /// Future (unsupported) version of witness program.
    V10 = 10,
    /// Future (unsupported) version of witness program.
    V11 = 11,
    /// Future (unsupported) version of witness program.
    V12 = 12,
    /// Future (unsupported) version of witness program.
    V13 = 13,
    /// Future (unsupported) version of witness program.
    V14 = 14,
    /// Future (unsupported) version of witness program.
    V15 = 15,
    /// Future (unsupported) version of witness program.
    V16 = 16,
}
impl From<BdkWitnessVersion> for WitnessVersion {
    fn from(value: BdkWitnessVersion) -> Self {
        match value {
            BdkWitnessVersion::V0 => WitnessVersion::V0,
            BdkWitnessVersion::V1 => WitnessVersion::V1,
            BdkWitnessVersion::V2 => WitnessVersion::V2,
            BdkWitnessVersion::V3 => WitnessVersion::V3,
            BdkWitnessVersion::V4 => WitnessVersion::V4,
            BdkWitnessVersion::V5 => WitnessVersion::V5,
            BdkWitnessVersion::V6 => WitnessVersion::V6,
            BdkWitnessVersion::V7 => WitnessVersion::V7,
            BdkWitnessVersion::V8 => WitnessVersion::V8,
            BdkWitnessVersion::V9 => WitnessVersion::V9,
            BdkWitnessVersion::V10 => WitnessVersion::V10,
            BdkWitnessVersion::V11 => WitnessVersion::V11,
            BdkWitnessVersion::V12 => WitnessVersion::V12,
            BdkWitnessVersion::V13 => WitnessVersion::V13,
            BdkWitnessVersion::V14 => WitnessVersion::V14,
            BdkWitnessVersion::V15 => WitnessVersion::V15,
            BdkWitnessVersion::V16 => WitnessVersion::V16,
        }
    }
}

/// The method used to produce an address.
#[derive(Debug)]
pub enum Payload {
    /// P2PKH address.
    PubkeyHash { pubkey_hash: Vec<u8> },
    /// P2SH address.
    ScriptHash { script_hash: Vec<u8> },
    /// Segwit address.
    WitnessProgram {
        /// The witness program version.
        version: WitnessVersion,
        /// The witness program.
        program: Vec<u8>,
    },
}

/// Trait that logs at level INFO every update received (if any).
pub trait Progress: Send + Sync + 'static {
    /// Send a new progress update. The progress value should be in the range 0.0 - 100.0, and the message value is an
    /// optional text message that can be displayed to the user.
    fn update(&self, progress: f32, message: Option<String>);
}

pub enum ChangeSpendPolicy {
    ChangeAllowed,
    OnlyChange,
    ChangeForbidden,
}
impl From<ChangeSpendPolicy> for bdk_lite::wallet::tx_builder::ChangeSpendPolicy {
    fn from(value: ChangeSpendPolicy) -> Self {
        match value {
            ChangeSpendPolicy::ChangeAllowed => {
                bdk_lite::wallet::tx_builder::ChangeSpendPolicy::ChangeAllowed
            }
            ChangeSpendPolicy::OnlyChange => {
                bdk_lite::wallet::tx_builder::ChangeSpendPolicy::OnlyChange
            }
            ChangeSpendPolicy::ChangeForbidden => {
                bdk_lite::wallet::tx_builder::ChangeSpendPolicy::ChangeForbidden
            }
        }
    }
}
