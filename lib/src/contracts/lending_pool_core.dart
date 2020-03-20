import 'package:aave_sdk/src/abis/lending_pool_core.dart';
import 'package:web3dart/web3dart.dart';

class LendingPoolCore {
  DeployedContract _contract;

  LendingPoolCore(
    EthereumAddress address,
  ) {
    _contract = DeployedContract(
      ContractAbi.fromJson(
        lendingPoolCoreAbi,
        'LendingPool',
      ),
      address,
    );
  }

  EthereumAddress get address => _contract.address;
}
