import 'package:aave_sdk/src/abis/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

abstract class AToken extends Erc20 {
  final Erc20 underlyingAsset;

  DeployedContract _contract;

  AToken(
    Web3Client client,
    int chainId,
    String name,
    EthereumAddress address,
    this.underlyingAsset,
  ) : super(
          client,
          chainId,
          name,
          address,
        ) {
    _contract = DeployedContract(
      ContractAbi.fromJson(aTokenAbi, 'aToken'),
      address,
    );
  }

  Future<BigInt> principalBalanceOf(
    EthereumAddress address,
  ) async {
    final result = await client.call(
      contract: _contract,
      function: _contract.function('principalBalanceOf'),
      params: [
        address,
      ],
    );
    return result.first;
  }

  Future<TransactionReceipt> redirectInterestStreamOf(
    Credentials credentials,
    EthereumAddress from,
    EthereumAddress to, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        client,
        _contract,
        chainId,
        credentials,
        'redirectInterestStreamOf',
        maxGas,
        [from, to],
      );

  Future<TransactionReceipt> allowInterestRedirectionTo(
    Credentials credentials,
    EthereumAddress address, {
    int maxGas = 100000,
  }) =>
      sendAndWaitContractTransaction(
        client,
        _contract,
        chainId,
        credentials,
        'allowInterestRedirectionTo',
        maxGas,
        [address],
      );

  Future<EthereumAddress> getInterestRedirectionAddress(
    EthereumAddress address,
  ) async {
    final result = await client.call(
      contract: _contract,
      function: _contract.function('getInterestRedirectionAddress'),
      params: [
        address,
      ],
    );
    return result.first;
  }
}
