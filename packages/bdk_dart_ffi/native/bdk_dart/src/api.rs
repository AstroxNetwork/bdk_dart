pub use crate::bdk::blockchain::{BlockchainConfig, BlockchainInstance};
pub use crate::bdk::descriptor::BdkDescriptor;
pub use crate::bdk::psbt::Transaction;
pub use crate::bdk::types::*;
pub use crate::bdk::wallet::{DatabaseConfig, WalletInstance};

use crate::bdk::bip322::{simple_signature_with_segwit, simple_signature_with_taproot};
use crate::bdk::key::{DerivationPath, DescriptorPublicKey, DescriptorSecretKey, Mnemonic};
use crate::bdk::psbt::PartiallySignedTransaction;
use crate::bdk::types::{
    Address, AddressIndex, AddressInfo, Balance, BdkTxBuilderResult, ChangeSpendPolicy,
    KeychainKind, Network, Payload, RbfValue, Script, TransactionDetails, TxIn, TxOut, WordCount,
};
use crate::bdk::wallet::SignOptions;
use crate::frb_generated::RustOpaque;
use crate::secp256k1::{Secp256k1FFI, Secp256k1IdentityExport};
use crate::types::{
    Secp256k1FromSeedReq, Secp256k1RecoverReq, Secp256k1ShareSecretReq, Secp256k1SignReq,
    Secp256k1SignWithRngReq, Secp256k1SignWithSeedReq, Secp256k1VerifyReq, SignatureFFI
};

use bitcoin::{
    Address as BdkAddress, OutPoint as BdkOutPoint, Sequence, Transaction as BdkTransaction, Txid,
};
use bdk_lite::keys::DescriptorSecretKey as BdkDescriptorSecretKey;
use bdk_lite::Error;
use bdk_lite::wallet::tx_builder::{ForeignUtxo as BdkForeignUtxo, TxOrdering};
use bitcoin::hashes::hex::FromHex;
use bitcoin::hashes::hex::ToHex;
use std::str::FromStr;
use std::sync::{Arc, Mutex, RwLock};

use lazy_static::lazy_static;
lazy_static! {
    static ref RUNTIME: RwLock<Option<tokio::runtime::Runtime>> = RwLock::new(None);
}

pub struct Api {}

impl Api {
    //========Blockchain==========
    pub fn create_blockchain(
        config: BlockchainConfig,
    ) -> anyhow::Result<RustOpaque<BlockchainInstance>> {
        let blockchain = BlockchainInstance::new(config);
        return match blockchain {
            Ok(e) => Ok(RustOpaque::new(e)),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn get_height(blockchain: RustOpaque<BlockchainInstance>) -> anyhow::Result<u32> {
        return match blockchain.get_height() {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn get_blockchain_hash(
        blockchain_height: u32,
        blockchain: RustOpaque<BlockchainInstance>,
    ) -> anyhow::Result<String> {
        return match blockchain.get_block_hash(blockchain_height) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn estimate_fee(
        target: u64,
        blockchain: RustOpaque<BlockchainInstance>,
    ) -> anyhow::Result<f32> {
        return match blockchain.estimate_fee(target) {
            Ok(e) => Ok(e.as_sat_per_vb()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn broadcast(
        tx: String,
        blockchain: RustOpaque<BlockchainInstance>,
    ) -> anyhow::Result<String> {
        let transaction: Transaction = tx.into();
        return match blockchain.broadcast(transaction) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    pub fn get_tx(
        tx: String,
        blockchain: RustOpaque<BlockchainInstance>,
    ) -> anyhow::Result<String> {
        return match blockchain.get_tx(tx) {
            Ok(e) => Ok(hex::encode(e.serialize())),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //=========Transaction===========

    pub fn create_transaction(tx: Vec<u8>) -> anyhow::Result<String> {
        let res = Transaction::new(tx);
        match res {
            Ok(e) => Ok(e.into()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn tx_txid(tx: String) -> anyhow::Result<String> {
        let tx_: Transaction = tx.into();
        Ok(tx_.txid())
    }
    pub fn weight(tx: String) -> u64 {
        let tx_: Transaction = tx.into();
        tx_.weight()
    }
    pub fn size(tx: String) -> u64 {
        let tx_: Transaction = tx.into();
        tx_.size()
    }
    pub fn vsize(tx: String) -> u64 {
        let tx_: Transaction = tx.into();
        tx_.vsize()
    }
    pub fn serialize_tx(tx: String) -> Vec<u8> {
        let tx_: Transaction = tx.into();
        tx_.serialize()
    }
    pub fn is_coin_base(tx: String) -> bool {
        let tx_: Transaction = tx.into();
        tx_.is_coin_base()
    }
    pub fn is_explicitly_rbf(tx: String) -> bool {
        let tx_: Transaction = tx.into();
        tx_.is_explicitly_rbf()
    }
    pub fn is_lock_time_enabled(tx: String) -> bool {
        let tx_: Transaction = tx.into();
        tx_.is_lock_time_enabled()
    }
    pub fn version(tx: String) -> i32 {
        let tx_: Transaction = tx.into();
        tx_.version()
    }
    pub fn lock_time(tx: String) -> u32 {
        let tx_: Transaction = tx.into();
        tx_.lock_time()
    }
    pub fn input(tx: String) -> Vec<TxIn> {
        let tx_: Transaction = tx.into();
        tx_.input()
    }
    pub fn output(tx: String) -> Vec<TxOut> {
        let tx_: Transaction = tx.into();
        tx_.output()
    }

    //========PartiallySignedTransaction==========
    pub fn serialize_psbt(psbt_str: String) -> anyhow::Result<String> {
        let psbt = PartiallySignedTransaction::new(psbt_str);
        return match psbt {
            Ok(e) => Ok(e.serialize()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn psbt_txid(psbt_str: String) -> anyhow::Result<String> {
        let psbt = PartiallySignedTransaction::new(psbt_str);
        return match psbt {
            Ok(e) => Ok(e.txid()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn extract_tx(psbt_str: String) -> anyhow::Result<String> {
        let psbt = PartiallySignedTransaction::new(psbt_str);
        return match psbt {
            Ok(e) => Ok(e.extract_tx().into()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn psbt_fee_rate(psbt_str: String) -> Option<f32> {
        let psbt = PartiallySignedTransaction::new(psbt_str);
        match psbt.unwrap().fee_rate() {
            None => None,
            Some(e) => Some(e.as_sat_per_vb()),
        }
    }
    pub fn psbt_fee_amount(psbt_str: String) -> Option<u64> {
        let psbt = PartiallySignedTransaction::new(psbt_str);
        psbt.unwrap().fee_amount()
    }
    pub fn combine_psbt(psbt_str: String, other: String) -> anyhow::Result<String> {
        let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
        let other = PartiallySignedTransaction::new(other).unwrap();
        return match psbt.combine(Arc::new(other)) {
            Ok(e) => Ok(e.serialize()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn json_serialize(psbt_str: String) -> anyhow::Result<String> {
        let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
        Ok(psbt.json_serialize())
    }

    pub fn get_inputs(psbt_str: String) -> anyhow::Result<Vec<TxOut>> {
        let psbt = PartiallySignedTransaction::new(psbt_str).unwrap();
        Ok(psbt.get_inputs())
    }

    //========TxBuilder==========
    pub fn tx_builder_finish(
        wallet: RustOpaque<WalletInstance>,
        recipients: Vec<ScriptAmount>,
        txs: Vec<TxBytes>,
        unspendable: Vec<OutPoint>,
        foreign_utxos: Vec<ForeignUtxo>,
        change_policy: ChangeSpendPolicy,
        manually_selected_only: bool,
        fee_rate: Option<f32>,
        fee_absolute: Option<u64>,
        drain_wallet: bool,
        drain_to: Option<Script>,
        rbf: Option<RbfValue>,
        data: Vec<u8>,
        shuffle_utxo: Option<bool>,
    ) -> anyhow::Result<BdkTxBuilderResult> {
        let binding = wallet.get_wallet();
        let mut tx_builder = binding.build_tx();

        for e in recipients {
            tx_builder.add_recipient(e.script.into(), e.amount);
        }
        tx_builder.change_policy(change_policy.into());

        match shuffle_utxo {
            None => {
                tx_builder.ordering(TxOrdering::Untouched);
            }
            Some(r) => {
                if r == true {
                    tx_builder.ordering(TxOrdering::Shuffle);
                } else {
                    tx_builder.ordering(TxOrdering::Untouched);
                }
            }
        };

        if !foreign_utxos.is_empty() {
            // let bdk_utxos: Vec<BdkOutPoint> = utxos.iter().map(BdkOutPoint::from).collect();
            // let utxos: &[BdkOutPoint] = &bdk_utxos;
            // tx_builder.add_utxos(utxos).unwrap();
            let utxos = foreign_utxos
                .iter()
                .map(BdkForeignUtxo::from)
                .collect::<Vec<BdkForeignUtxo>>();
            tx_builder.add_utxo_foreign(&utxos).unwrap();
        }
        if !unspendable.is_empty() {
            let bdk_unspendable: Vec<BdkOutPoint> =
                unspendable.iter().map(BdkOutPoint::from).collect();
            tx_builder.unspendable(bdk_unspendable);
        }
        if manually_selected_only {
            tx_builder.manually_selected_only();
        }
        if let Some(sat_per_vb) = fee_rate {
            tx_builder.fee_rate(bdk_lite::FeeRate::from_sat_per_vb(sat_per_vb));
        }
        if let Some(fee_amount) = fee_absolute {
            tx_builder.fee_absolute(fee_amount);
        }
        if drain_wallet {
            tx_builder.drain_wallet();
        }
        if let Some(script_) = drain_to {
            tx_builder.drain_to(script_.into());
        }
        if let Some(rbf) = &rbf {
            match *rbf {
                RbfValue::RbfDefault => {
                    tx_builder.enable_rbf();
                }
                RbfValue::Value(nsequence) => {
                    tx_builder.enable_rbf_with_sequence(Sequence(nsequence));
                }
            }
        }
        if !data.is_empty() {
            tx_builder.add_data(data.as_slice());
        }

        if !txs.is_empty() {
            let tt = txs
                .iter()
                .map(|f| f.to_transaction().unwrap().internal)
                .collect::<Vec<BdkTransaction>>();
            tx_builder.add_txs(&tt).unwrap();
        }

        return match tx_builder.finish() {
            Ok((p, d)) => Ok(BdkTxBuilderResult(
                Arc::new(PartiallySignedTransaction {
                    internal: Mutex::new(p.clone()),
                })
                    .serialize(),
                TransactionDetails::from(&d),
            )),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //========TxBuilder==========
    pub fn tx_cal_fee_finish(
        wallet: RustOpaque<WalletInstance>,
        recipients: Vec<ScriptAmount>,
        txs: Vec<TxBytes>,
        unspendable: Vec<OutPoint>,
        foreign_utxos: Vec<ForeignUtxo>,
        change_policy: ChangeSpendPolicy,
        manually_selected_only: bool,
        fee_rate: Option<f32>,
        fee_absolute: Option<u64>,
        drain_wallet: bool,
        drain_to: Option<Script>,
        rbf: Option<RbfValue>,
        data: Vec<u8>,
        shuffle_utxo: Option<bool>,
    ) -> anyhow::Result<u64> {
        let binding = wallet.get_wallet();
        let mut tx_builder = binding.build_tx();

        for e in recipients {
            tx_builder.add_recipient(e.script.into(), e.amount);
        }
        tx_builder.change_policy(change_policy.into());

        match shuffle_utxo {
            None => {
                tx_builder.ordering(TxOrdering::Untouched);
            }
            Some(r) => {
                if r == true {
                    tx_builder.ordering(TxOrdering::Shuffle);
                } else {
                    tx_builder.ordering(TxOrdering::Untouched);
                }
            }
        };

        if !foreign_utxos.is_empty() {
            // let bdk_utxos: Vec<BdkOutPoint> = utxos.iter().map(BdkOutPoint::from).collect();
            // let utxos: &[BdkOutPoint] = &bdk_utxos;
            // tx_builder.add_utxos(utxos).unwrap();
            let utxos = foreign_utxos
                .iter()
                .map(BdkForeignUtxo::from)
                .collect::<Vec<BdkForeignUtxo>>();
            tx_builder.add_utxo_foreign(&utxos).unwrap();
        }
        if !unspendable.is_empty() {
            let bdk_unspendable: Vec<BdkOutPoint> =
                unspendable.iter().map(BdkOutPoint::from).collect();
            tx_builder.unspendable(bdk_unspendable);
        }
        if manually_selected_only {
            tx_builder.manually_selected_only();
        }
        if let Some(sat_per_vb) = fee_rate {
            tx_builder.fee_rate(bdk_lite::FeeRate::from_sat_per_vb(sat_per_vb));
        }
        if let Some(fee_amount) = fee_absolute {
            tx_builder.fee_absolute(fee_amount);
        }
        if drain_wallet {
            tx_builder.drain_wallet();
        }
        if let Some(script_) = drain_to {
            tx_builder.drain_to(script_.into());
        }
        if let Some(rbf) = &rbf {
            match *rbf {
                RbfValue::RbfDefault => {
                    tx_builder.enable_rbf();
                }
                RbfValue::Value(nsequence) => {
                    tx_builder.enable_rbf_with_sequence(Sequence(nsequence));
                }
            }
        }
        if !data.is_empty() {
            tx_builder.add_data(data.as_slice());
        }

        if !txs.is_empty() {
            let tt = txs
                .iter()
                .map(|f| f.to_transaction().unwrap().internal)
                .collect::<Vec<BdkTransaction>>();
            tx_builder.add_txs(&tt).unwrap();
        }

        return match tx_builder.cal_fee() {
            Ok(r) => Ok(r),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //========BumpFeeTxBuilder==========
    pub fn bump_fee_tx_builder_finish(
        txid: String,
        fee_rate: f32,
        allow_shrinking: Option<String>,
        wallet: RustOpaque<WalletInstance>,
        enable_rbf: bool,
        keep_change: bool,
        n_sequence: Option<u32>,
    ) -> anyhow::Result<BdkTxBuilderResult> {
        let txid = Txid::from_str(txid.as_str()).unwrap();
        let bdk_wallet = wallet.get_wallet();
        let mut tx_builder = match bdk_wallet.build_fee_bump(txid, Some(keep_change)) {
            Ok(e) => e,
            Err(e) => anyhow::bail!("{:?}", e),
        };
        tx_builder.fee_rate(bdk_lite::FeeRate::from_sat_per_vb(fee_rate));
        if let Some(allow_shrinking) = &allow_shrinking {
            let address = BdkAddress::from_str(allow_shrinking)
                .map_err(|e| Error::Generic(e.to_string()))
                .unwrap();
            let script = address.script_pubkey();
            tx_builder.allow_shrinking(script).unwrap();
        }
        if let Some(n_sequence) = n_sequence {
            tx_builder.enable_rbf_with_sequence(bdk_lite::bitcoin::Sequence(n_sequence));
        }
        if enable_rbf {
            tx_builder.enable_rbf();
        }
        return match tx_builder.finish() {
            Ok((p, d)) => Ok(BdkTxBuilderResult(
                Arc::new(PartiallySignedTransaction {
                    internal: Mutex::new(p.clone()),
                })
                    .serialize(),
                TransactionDetails::from(&d),
            )),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //================Descriptor=========
    pub fn create_descriptor(
        descriptor: String,
        network: Network,
    ) -> anyhow::Result<RustOpaque<BdkDescriptor>> {
        return match BdkDescriptor::new(descriptor, network.into()) {
            Ok(e) => Ok(RustOpaque::new(e)),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn import_single_wif(
        wif: String,
        address_type: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        return RustOpaque::new(BdkDescriptor::import_single_wif(
            wif.as_str(),
            AddressType::from(address_type),
            network.into(),
        ));
    }

    pub fn new_bip44_descriptor(
        key_chain_kind: KeychainKind,
        secret_key: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorSecretKey::from_string(secret_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip44(key, key_chain_kind.into(), network.into());
        RustOpaque::new(descriptor)
    }
    pub fn new_bip44_public(
        key_chain_kind: KeychainKind,
        public_key: String,
        network: Network,
        fingerprint: String,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip44_public(
            key,
            fingerprint,
            key_chain_kind.into(),
            network.into(),
        );
        RustOpaque::new(descriptor)
    }

    pub fn new_bip44_tr_descriptor(
        key_chain_kind: KeychainKind,
        secret_key: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorSecretKey::from_string(secret_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip44_tr(key, key_chain_kind.into(), network.into());
        RustOpaque::new(descriptor)
    }
    pub fn new_bip44_tr_public(
        key_chain_kind: KeychainKind,
        public_key: String,
        network: Network,
        fingerprint: String,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip44_tr_public(
            key,
            fingerprint,
            key_chain_kind.into(),
            network.into(),
        );
        RustOpaque::new(descriptor)
    }
    pub fn new_bip49_descriptor(
        key_chain_kind: KeychainKind,
        secret_key: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorSecretKey::from_string(secret_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip49(key, key_chain_kind.into(), network.into());
        RustOpaque::new(descriptor)
    }
    pub fn new_bip49_public(
        key_chain_kind: KeychainKind,
        public_key: String,
        network: Network,
        fingerprint: String,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip49_public(
            key,
            fingerprint,
            key_chain_kind.into(),
            network.into(),
        );
        RustOpaque::new(descriptor)
    }
    pub fn new_bip84_descriptor(
        key_chain_kind: KeychainKind,
        secret_key: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorSecretKey::from_string(secret_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip84(key, key_chain_kind.into(), network.into());
        RustOpaque::new(descriptor)
    }
    pub fn new_bip84_public(
        key_chain_kind: KeychainKind,
        public_key: String,
        network: Network,
        fingerprint: String,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip84_public(
            key,
            fingerprint,
            key_chain_kind.into(),
            network.into(),
        );
        RustOpaque::new(descriptor)
    }

    pub fn new_bip86_descriptor(
        key_chain_kind: KeychainKind,
        secret_key: String,
        network: Network,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorSecretKey::from_string(secret_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip86(key, key_chain_kind.into(), network.into());
        RustOpaque::new(descriptor)
    }
    pub fn new_bip86_public(
        key_chain_kind: KeychainKind,
        public_key: String,
        network: Network,
        fingerprint: String,
    ) -> RustOpaque<BdkDescriptor> {
        let key = match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor = BdkDescriptor::new_bip86_public(
            key,
            fingerprint,
            key_chain_kind.into(),
            network.into(),
        );
        RustOpaque::new(descriptor)
    }

    pub fn as_string_private(descriptor: RustOpaque<BdkDescriptor>) -> String {
        descriptor.as_string_private()
    }
    pub fn as_string(descriptor: RustOpaque<BdkDescriptor>) -> String {
        descriptor.as_string()
    }

    pub fn derive_address_at(
        descriptor: RustOpaque<BdkDescriptor>,
        index: u32,
        network: Network,
    ) -> anyhow::Result<AddressInfo> {
        return match descriptor.derive_address_index(index, network.into()) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //====================== Descriptor Secret =================
    pub fn create_descriptor_secret(
        network: Network,
        mnemonic: String,
        password: Option<String>,
    ) -> anyhow::Result<String> {
        let mnemonic = Mnemonic::from_str(mnemonic).unwrap();
        return match DescriptorSecretKey::new(network.into(), mnemonic, password) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    pub fn create_derived_descriptor_secret(
        network: Network,
        mnemonic: String,
        path: String,
        password: Option<String>,
    ) -> anyhow::Result<String> {
        let mnemonic = Mnemonic::from_str(mnemonic).unwrap();
        let derivation_path = Arc::new(DerivationPath::new(path).unwrap());
        return match DescriptorSecretKey::new_derived(
            network.into(),
            mnemonic,
            derivation_path,
            password,
        ) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn descriptor_secret_from_string(secret: String) -> anyhow::Result<String> {
        return match DescriptorSecretKey::from_string(secret) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn extend_descriptor_secret(secret: String, path: String) -> String {
        let res = Self::descriptor_secret_config(secret, Some(path), false);
        res.as_string()
    }
    pub fn derive_descriptor_secret(secret: String, path: String) -> String {
        let res = Self::descriptor_secret_config(secret, Some(path), true);
        res.as_string()
    }
    pub fn as_secret_bytes(secret: String) -> anyhow::Result<Vec<u8>> {
        let secret = match BdkDescriptorSecretKey::from_str(secret.as_str()) {
            Ok(e) => e,
            Err(e) => anyhow::bail!("{:?}", e),
        };
        let descriptor_secret = DescriptorSecretKey {
            descriptor_secret_key_mutex: Mutex::new(secret),
        };
        return match descriptor_secret.secret_bytes() {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn as_public(secret: String) -> anyhow::Result<String> {
        let secret = match BdkDescriptorSecretKey::from_str(secret.as_str()) {
            Ok(e) => e,
            Err(e) => anyhow::bail!("{:?}", e),
        };
        let descriptor_secret = DescriptorSecretKey {
            descriptor_secret_key_mutex: Mutex::new(secret),
        };

        match descriptor_secret.as_public() {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn get_pub_from_secret_bytes(bytes: Vec<u8>) -> String {
        DescriptorSecretKey::get_pub_from_secret_bytes(bytes)
    }

    fn descriptor_secret_config(
        secret: String,
        path: Option<String>,
        derive: bool,
    ) -> Arc<DescriptorSecretKey> {
        let secret = match BdkDescriptorSecretKey::from_str(secret.as_str()) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        let descriptor_secret = DescriptorSecretKey {
            descriptor_secret_key_mutex: Mutex::new(secret),
        };

        if path.is_none() {
            return Arc::new(descriptor_secret);
        }
        let derivation_path = Arc::new(
            DerivationPath::new(path.expect("Invalid derivation path").to_string()).unwrap(),
        );
        return if derive {
            match descriptor_secret.derive(derivation_path) {
                Ok(e) => e,
                Err(e) => panic!("{:?}", e),
            }
        } else {
            match descriptor_secret.extend(derivation_path) {
                Ok(e) => e,
                Err(e) => panic!("{:?}", e),
            }
        };
    }

    //==============Derivation Path ==========
    pub fn create_derivation_path(path: String) -> anyhow::Result<String> {
        return match DerivationPath::new(path) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //================Descriptor Public=========
    pub fn descriptor_public_from_string(public_key: String) -> anyhow::Result<String> {
        return match DescriptorPublicKey::from_string(public_key) {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    pub fn master_finterprint(xpub: String) -> anyhow::Result<String> {
        let descriptor_public = DescriptorPublicKey::from_string(xpub).expect("Cannot parse xpub");
        Ok(descriptor_public.master_fingerprint().to_hex())
    }

    pub fn create_descriptor_public(
        xpub: Option<String>,
        path: String,
        derive: bool,
    ) -> anyhow::Result<String> {
        let derivation_path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
        let descriptor_public = DescriptorPublicKey::from_string(xpub.unwrap()).unwrap();
        return if derive {
            match descriptor_public.clone().derive(derivation_path) {
                Ok(e) => Ok(e.as_string()),
                Err(e) => anyhow::bail!("{:?}", e),
            }
        } else {
            match descriptor_public.clone().extend(derivation_path) {
                Ok(e) => Ok(e.as_string()),
                Err(e) => anyhow::bail!("{:?}", e),
            }
        };
    }
    pub fn to_public_string(xpub: String) -> anyhow::Result<String> {
        match bip32::XPub::from_str(xpub.as_str()) {
            Ok(r) => Ok(r.to_bytes().to_hex()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    //============ Script Class===========
    pub fn create_script(raw_output_script: Vec<u8>) -> anyhow::Result<Script> {
        return match Script::new(raw_output_script) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }

    //================Address============
    pub fn create_address(address: String) -> anyhow::Result<String> {
        return match Address::new(address) {
            Ok(e) => Ok(e.address.to_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn address_from_script(script: Script, network: Network) -> anyhow::Result<String> {
        return match Address::from_script(script, network) {
            Ok(e) => Ok(e.address.to_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        };
    }
    pub fn address_to_script_pubkey(address: String) -> anyhow::Result<Script> {
        match Address::new(address) {
            Ok(e) => Ok(e.script_pubkey().into()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn payload(address: String) -> anyhow::Result<Payload> {
        match Address::new(address) {
            Ok(e) => Ok(e.payload()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn address_network(address: String) -> anyhow::Result<Network> {
        match Address::new(address) {
            Ok(e) => Ok(e.network()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn get_address_type(address: String) -> anyhow::Result<String> {
        match Address::get_address_type(address) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    //========Wallet==========
    pub fn create_wallet(
        descriptor: RustOpaque<BdkDescriptor>,
        change_descriptor: Option<RustOpaque<BdkDescriptor>>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> anyhow::Result<RustOpaque<WalletInstance>> {
        match WalletInstance::new(
            Arc::new(descriptor),
            change_descriptor.map(|x| Arc::new(x)),
            network.into(),
            database_config,
        ) {
            Ok(e) => Ok(e.into()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn get_address(
        wallet: RustOpaque<WalletInstance>,
        address_index: AddressIndex,
    ) -> anyhow::Result<AddressInfo> {
        match wallet.get_address(address_index) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn get_internal_address(
        wallet: RustOpaque<WalletInstance>,
        address_index: AddressIndex,
    ) -> anyhow::Result<AddressInfo> {
        match wallet.get_internal_address(address_index) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn get_balance(wallet: RustOpaque<WalletInstance>) -> anyhow::Result<Balance> {
        match wallet.get_balance() {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn list_unspent_outputs(
        wallet: RustOpaque<WalletInstance>,
    ) -> anyhow::Result<Vec<crate::bdk::wallet::LocalUtxo>> {
        match wallet.list_unspent() {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn get_transactions(
        wallet: RustOpaque<WalletInstance>,
        include_raw: bool,
    ) -> anyhow::Result<Vec<TransactionDetails>> {
        match wallet.list_transactions(include_raw) {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn sign(
        wallet: RustOpaque<WalletInstance>,
        psbt_str: String,
        sign_options: Option<SignOptions>,
    ) -> Option<String> {
        let psbt = match PartiallySignedTransaction::new(psbt_str) {
            Ok(e) => e,
            Err(e) => panic!("{:?}", e),
        };
        return match wallet.sign(&psbt, sign_options).unwrap() {
            true => Some(psbt.serialize()),
            false => None,
        };
    }
    pub fn wallet_network(wallet: RustOpaque<WalletInstance>) -> Network {
        wallet.get_wallet().network().into()
    }
    pub fn list_unspent(
        wallet: RustOpaque<WalletInstance>,
    ) -> anyhow::Result<Vec<crate::bdk::wallet::LocalUtxo>> {
        match wallet.list_unspent() {
            Ok(e) => Ok(e),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }

    pub fn cache_address(
        wallet: RustOpaque<WalletInstance>,
        cache_size: u32,
    ) -> anyhow::Result<bool> {
        match wallet.cache_address(cache_size) {
            Ok(e) => Ok(e),
            Err(e) => panic!("{:?}", e),
        }
    }

    //================== Mnemonic ==========
    pub fn generate_seed_from_word_count(word_count: WordCount) -> String {
        let mnemonic = Mnemonic::new(word_count.into());
        mnemonic.as_string()
    }
    pub fn generate_seed_from_string(mnemonic: String) -> anyhow::Result<String> {
        let mnemonic = Mnemonic::from_str(mnemonic);
        match mnemonic {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    pub fn generate_seed_from_entropy(entropy: Vec<u8>) -> anyhow::Result<String> {
        let mnemonic = Mnemonic::from_entropy(entropy);
        match mnemonic {
            Ok(e) => Ok(e.as_string()),
            Err(e) => anyhow::bail!("{:?}", e),
        }
    }
    //================== BIP322 ==========
    pub fn bip322_sign_segwit(secret: Vec<u8>, message: String) -> String {
        simple_signature_with_segwit(message.as_str(), &secret)
    }

    pub fn bip322_sign_taproot(secret: Vec<u8>, message: String) -> String {
        simple_signature_with_taproot(message.as_str(), &secret)
    }
}

/// --------------------
/// WIF
/// --------------------
/// hex_bytes_to_wif

pub fn hex_bytes_to_wif(hex: String, network: Network) -> anyhow::Result<String> {
    let bytes = Vec::from_hex(hex.as_str()).map_err(|e| Error::Generic(e.to_string()))?;
    let secret_key = bitcoin::secp256k1::SecretKey::from_slice(&bytes).map_err(|e| Error::Generic(e.to_string()))?;
    let bitcoin_network = bitcoin::Network::from(network);
    let private_key = bitcoin::PrivateKey {
        compressed: true,
        network: bitcoin_network,
        inner: secret_key,
    };
    Ok(private_key.to_wif())
}

/// ---------------------
/// secp256k1
/// ---------------------

pub fn secp256k1_from_seed(req: Secp256k1FromSeedReq) -> Secp256k1IdentityExport {
    Secp256k1IdentityExport::from_raw(Secp256k1FFI::from_seed(req))
}

pub fn secp256k1_sign(req: Secp256k1SignWithSeedReq) -> SignatureFFI {
    Secp256k1FFI::from_seed(Secp256k1FromSeedReq { seed: req.seed })
        .sign(Secp256k1SignReq { msg: req.msg })
        .unwrap()
}

pub fn secp256k1_sign_with_rng(req: Secp256k1SignWithRngReq) -> SignatureFFI {
    Secp256k1FFI::sign_with_rng(req).unwrap()
}

pub fn secp256k1_sign_recoverable(req: Secp256k1SignWithSeedReq) -> SignatureFFI {
    Secp256k1FFI::from_seed(Secp256k1FromSeedReq { seed: req.seed })
        .sign_recoverable(Secp256k1SignReq { msg: req.msg })
        .unwrap()
}

pub fn secp256k1_verify(req: Secp256k1VerifyReq) -> bool {
    Secp256k1FFI::verify_signature(req)
}

pub fn secp256k1_get_shared_secret(req: Secp256k1ShareSecretReq) -> Vec<u8> {
    Secp256k1FFI::get_share_secret(req).unwrap()
}

pub fn secp256k1_recover(req: Secp256k1RecoverReq) -> Vec<u8> {
    Secp256k1FFI::recover_pub_key(req).unwrap()
}
