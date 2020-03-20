import 'package:aave_sdk/src/models/interest_rate_mode.dart';
import 'package:web3dart/web3dart.dart';

class BorrowEvent {
  final EthereumAddress reserve;
  final EthereumAddress user;
  final EtherAmount amount;
  final InterestRateMode interestRateMode;
  final num borrowRate;
  final EtherAmount originationFee;
  final EtherAmount borrowBalanceIncrease;
  final BigInt referral;
  final BigInt timestamp;

  BorrowEvent(
    this.reserve,
    this.user,
    this.amount,
    this.interestRateMode,
    this.borrowRate,
    this.originationFee,
    this.borrowBalanceIncrease,
    this.referral,
    this.timestamp,
  );

  @override
  String toString() =>
      'BorrowEvent{ ${reserve.hex}, ${user.hex}, ${amount.getValueInUnit(EtherUnit.ether)}, $interestRateMode, ${borrowRate.toStringAsPrecision(3)}, ${originationFee.getValueInUnit(EtherUnit.ether)}, ${borrowBalanceIncrease.getValueInUnit(EtherUnit.ether)}, ${referral}, ${timestamp} }';
}
