import 'package:web3dart/web3dart.dart';

class ReserveConfigurationData {
  final int ltv;
  final int liquidationThreshold;
  final int liquidationDiscount;
  final EthereumAddress interestRateStrategyAddress;
  final bool usageasCollateralEnabled;
  final bool borrowingEnabled;
  final bool fixedBorrowRateEnabled;
  final bool isActive;

  ReserveConfigurationData(
    this.ltv,
    this.liquidationThreshold,
    this.liquidationDiscount,
    this.interestRateStrategyAddress,
    this.usageasCollateralEnabled,
    this.borrowingEnabled,
    this.fixedBorrowRateEnabled,
    this.isActive,
  );

  @override
  String toString() =>
      'ReserveConfigurationData{ $ltv, $liquidationThreshold, $liquidationDiscount, $interestRateStrategyAddress, $usageasCollateralEnabled, $borrowingEnabled, $fixedBorrowRateEnabled, $isActive }';
}
