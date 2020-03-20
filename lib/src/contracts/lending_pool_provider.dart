import 'package:aave_sdk/src/abis/lending_pool_address_provider.dart';
import 'package:web3dart/web3dart.dart';

class LendingPoolAddressesProvider {
  final Web3Client _client;

  DeployedContract _contract;

  LendingPoolAddressesProvider(
    this._client,
    EthereumAddress _address,
  ) {
    _contract = DeployedContract(
      ContractAbi.fromJson(
        lendingPoolAddressProviderAbi,
        'LendingPoolAddressesProvider',
      ),
      _address,
    );
  }

  /// Needs to be used whenever it is needed to fetch the address of the latest implementation of the LendingPool contract.
  Future<EthereumAddress> getLendingPool() async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getLendingPool'),
      params: [],
    );
    return result.first;
  }
}
