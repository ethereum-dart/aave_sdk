import 'dart:async';

import 'package:aave_sdk/src/a_token/a_bat.dart';
import 'package:aave_sdk/src/a_token/a_dai.dart';
import 'package:aave_sdk/src/a_token/a_eth.dart';
import 'package:aave_sdk/src/a_token/a_knc.dart';
import 'package:aave_sdk/src/a_token/a_lend.dart';
import 'package:aave_sdk/src/a_token/a_link.dart';
import 'package:aave_sdk/src/a_token/a_mana.dart';
import 'package:aave_sdk/src/a_token/a_mkr.dart';
import 'package:aave_sdk/src/a_token/a_rep.dart';
import 'package:aave_sdk/src/a_token/a_snx.dart';
import 'package:aave_sdk/src/a_token/a_synthetix_usd.dart';
import 'package:aave_sdk/src/a_token/a_tether.dart';
import 'package:aave_sdk/src/a_token/a_true_usd.dart';
import 'package:aave_sdk/src/a_token/a_usd_c.dart';
import 'package:aave_sdk/src/a_token/a_wbtc.dart';
import 'package:aave_sdk/src/a_token/a_zrx.dart';
import 'package:aave_sdk/src/abis/lending_pool.dart';
import 'package:aave_sdk/src/models/borrow_event.dart';
import 'package:aave_sdk/src/models/interest_rate_mode.dart';
import 'package:aave_sdk/src/models/reserve_configuration_data.dart';
import 'package:aave_sdk/src/models/user_account_data.dart';
import 'package:aave_sdk/src/models/user_reserve_data.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class LendingPool {
  final Web3Client Function() _clientFactory;
  final int _chainId;

  final AEth aEth;

  final ADai aDai;
  final AUsdC aUsdc;
  final ASynthetixUsd aSynthetixUsd;
  final ATrueUsd aTrueUsd;
  final ATether aTether;
  final ABat aBat;
  final AKnc aKnc;
  final ALend aLend;
  final ALink aLink;
  final AMana aMana;
  final AMkr aMkr;
  final ARep aRep;
  final ASnx aSnx;
  final AWBtc awBtc;
  final AZrx aZrx;

  DeployedContract _contract;
  List<Erc20> _supportedErc20;
  Web3Client _client;

  LendingPool(
    this._clientFactory,
    EthereumAddress _address,
    this._chainId,
    this.aEth,
    this.aDai,
    this.aUsdc,
    this.aSynthetixUsd,
    this.aTrueUsd,
    this.aTether,
    this.aBat,
    this.aKnc,
    this.aLend,
    this.aLink,
    this.aMana,
    this.aMkr,
    this.aRep,
    this.aSnx,
    this.awBtc,
    this.aZrx,
  ) {
    _contract = DeployedContract(
      ContractAbi.fromJson(
        lendingPoolAbi,
        'LendingPool',
      ),
      _address,
    );
    _client = _clientFactory();
    _supportedErc20 = [
      aEth.underlyingAsset,
      aDai.underlyingAsset,
      aUsdc.underlyingAsset,
      aSynthetixUsd.underlyingAsset,
      aTrueUsd.underlyingAsset,
      aTether.underlyingAsset,
      aBat.underlyingAsset,
      aKnc.underlyingAsset,
      aLend.underlyingAsset,
      aLink.underlyingAsset,
      aMana.underlyingAsset,
      aMkr.underlyingAsset,
      aRep.underlyingAsset,
      aSnx.underlyingAsset,
      awBtc.underlyingAsset,
      aZrx.underlyingAsset,
    ];
  }

  List<Erc20> get supportedErc20 => _supportedErc20;

  Stream<BorrowEvent> get borrowEvent => _clientFactory()
          .events(
            FilterOptions.events(
              contract: _contract,
              event: _contract.event('Borrow'),
            ),
          )
          .map(
            (event) => _contract
                .event('Borrow')
                .decodeResults(event.topics, event.data),
          )
          .map((event) {
        final reserve = event[0] as EthereumAddress;
        final underlyingAsset = _supportedErc20.firstWhere(
            (element) => element.address == reserve,
            orElse: () => null);
        if (underlyingAsset == null) {
          print(event);
          return null;
        }
        final amount =
            EtherAmount.fromUnitAndValue(underlyingAsset.unit, event[2]);
        return BorrowEvent(
          event[0],
          event[1],
          amount,
          deserializeInterestRateMode(event[3].toInt()),
          event[4] / BigInt.from(10).pow(25),
          EtherAmount.inWei(event[5] * BigInt.from(100)),
          EtherAmount.fromUnitAndValue(underlyingAsset.unit, event[6]),
          event[7],
          event[8],
        );
      });

  /// Deposits a certain [amount] of an asset specified by the [reserve] parameter.
  Future<TransactionReceipt> deposit(
    Credentials credentials,
    EthereumAddress reserve,
    EtherAmount amount, {
    BigInt referral,
    int maxGas = 180000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'deposit',
        maxGas,
        [
          reserve,
          amount.getInWei,
          referral ?? BigInt.from(19),
        ],
      );

  /// Using this function users can decide whether or not use a specific deposit as collateral.
  /// Users will only be able to disable deposits that are not being used as collateral yet.
  Future<TransactionReceipt> setUserUseReserveAsCollateral(
    Credentials credentials,
    EthereumAddress reserve,
    bool useAsCollateral, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'setUserUseReserveAsCollateral',
        maxGas,
        [
          reserve,
          useAsCollateral,
        ],
      );

  /// The borrow() function transfer a specific amount of the asset identified by the [reserve] parameter to the msg.sender,
  /// provided that the caller has preemptively deposited enough collateral to cover the borrow.
  Future<TransactionReceipt> borrow(
    Credentials credentials,
    EthereumAddress reserve,
    EtherAmount amount,
    InterestRateMode interestRateMode, {
    int referral,
    int maxGas = 500000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'borrow',
        maxGas,
        [
          reserve,
          amount.getInWei,
          interestRateMode == InterestRateMode.stable ? 1 : 2,
          referral ?? BigInt.from(19),
        ],
      );

  Future<TransactionReceipt> repay(
    Credentials credentials,
    EthereumAddress reserve,
    EtherAmount amount,
    EthereumAddress onBehalfOf, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'repay',
        maxGas,
        [
          reserve,
          amount.getInWei,
          onBehalfOf,
        ],
      );

  Future<TransactionReceipt> rebalanceFixedBorrowRate(
    Credentials credentials,
    EthereumAddress reserve,
    EthereumAddress user, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'rebalanceFixedBorrowRate',
        maxGas,
        [
          reserve,
          user,
        ],
      );

  Future<TransactionReceipt> flashLoan(
    Credentials credentials,
    EthereumAddress receiver,
    EthereumAddress reserve,
    EtherAmount amount,
    List<int> params, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'flashLoan',
        maxGas,
        [
          receiver,
          reserve,
          amount,
          params,
        ],
      );

  Future<TransactionReceipt> liquidationCall(
    Credentials credentials,
    EthereumAddress collateral,
    EthereumAddress reserve,
    EthereumAddress user,
    EtherAmount purchaseAmount,
    bool receiveAToken, {
    int maxGas = 500000,
  }) =>
      sendAndWaitContractTransaction(
        _client,
        _contract,
        _chainId,
        credentials,
        'flashLoan',
        maxGas,
        [
          collateral,
          reserve,
          user,
          purchaseAmount,
          receiveAToken,
        ],
      );

  Future<ReserveConfigurationData> getReserveConfigurationData(
    EthereumAddress reserve,
  ) async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getReserveConfigurationData'),
      params: [reserve],
    );
    return ReserveConfigurationData(
      (result[0] as BigInt).toInt(),
      (result[1] as BigInt).toInt(),
      (result[2] as BigInt).toInt(),
      result[3],
      result[4] != 0,
      result[5] != 0,
      result[6] != 0,
      result[7] != 0,
    );
  }

  Future getReserveData(
    EthereumAddress reserve,
  ) async {
    //  todo: implement this
    throw UnimplementedError();
  }

  /// Returns information of a reserve exclusively related with a particular [user] address
  Future<UserAccountData> getUserAccountData(
    EthereumAddress user,
  ) async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getUserAccountData'),
      params: [user],
    );
    return UserAccountData(
      EtherAmount.inWei(result[0]),
      EtherAmount.inWei(result[1]),
      EtherAmount.inWei(result[2]),
      EtherAmount.inWei(result[3]),
      EtherAmount.inWei(result[4]),
      result[5],
      result[6],
      EtherAmount.inWei(result[7]),
    );
  }

  /// Returns information related to the [user] data on a specific [reserve]
  Future<UserReserveData> getUserReserveData(
    EthereumAddress reserve,
    EthereumAddress user,
  ) async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getUserReserveData'),
      params: [
        reserve,
        user,
      ],
    );
    final underlyingAsset = _supportedErc20.firstWhere(
        (element) => element.address == reserve,
        orElse: () => null);

    return UserReserveData(
      EtherAmount.fromUnitAndValue(underlyingAsset.unit, result[0]),
      EtherAmount.fromUnitAndValue(underlyingAsset.unit, result[1]),
      EtherAmount.fromUnitAndValue(underlyingAsset.unit, result[2]),
      result[3],
      result[4],
      EtherAmount.inWei(result[5]),
      result[6],
      result[7],
      result[8],
      result[9],
    );
  }

  /// Returns an array of all the active reserves addresses.
  Future<List<EthereumAddress>> getReserves() async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getReserves'),
      params: [],
    );
    final addresses = (result.first as List).cast<EthereumAddress>();
    return addresses;
  }
}
