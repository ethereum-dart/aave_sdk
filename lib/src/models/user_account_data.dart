import 'package:web3dart/web3dart.dart';

class UserAccountData {
  /// Aggregated deposits across all the reserves.
  final EtherAmount totalLiquidityETH;

  /// Aggregated collateral across all the reserves.
  final EtherAmount totalCollateralETH;

  /// Aggregated outstanding borrows across all the reserves.
  final EtherAmount totalBorrowsETH;

  /// Aggregated current outstanding fees in ETH.
  final EtherAmount totalFeesETH;

  /// Available amount to borrow
  final EtherAmount availableBorrowsETH;

  /// Current average liquidation threshold across all the collaterals deposited
  final BigInt currentLiquidationThreshold;

  /// Average Loan-to-Value between all the collaterals
  final BigInt ltv;

  /// Current Health Factor
  final EtherAmount healthFactor;

  UserAccountData(
    this.totalLiquidityETH,
    this.totalCollateralETH,
    this.totalBorrowsETH,
    this.totalFeesETH,
    this.availableBorrowsETH,
    this.currentLiquidationThreshold,
    this.ltv,
    this.healthFactor,
  );
}
