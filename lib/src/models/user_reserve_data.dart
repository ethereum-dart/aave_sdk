import 'package:web3dart/web3dart.dart';

class UserReserveData {
  final EtherAmount currentATokenBalance;

  final EtherAmount currentBorrowBalance;

  final EtherAmount principalBorrowBalance;

  final BigInt borrowRateMode;

  final BigInt borrowRate;

  final EtherAmount liquidityRate;

  final BigInt originationFee;

  final BigInt variableBorrowIndex;

  final BigInt lastUpdateTimestamp;

  final bool usageAsCollateralEnabled;

  UserReserveData(
    this.currentATokenBalance,
    this.currentBorrowBalance,
    this.principalBorrowBalance,
    this.borrowRateMode,
    this.borrowRate,
    this.liquidityRate,
    this.originationFee,
    this.variableBorrowIndex,
    this.lastUpdateTimestamp,
    this.usageAsCollateralEnabled,
  );

  @override
  String toString() {
    return 'UserReserveData{ $currentATokenBalance, $currentBorrowBalance, $principalBorrowBalance, $borrowRateMode, $borrowRate, $liquidityRate, $originationFee, $variableBorrowIndex, $lastUpdateTimestamp, $usageAsCollateralEnabled }';
  }
}
