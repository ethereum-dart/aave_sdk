import 'package:aave_sdk/src/contracts/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class AUsdC extends AToken {
  AUsdC(
    Web3Client client,
    int chainId,
    EthereumAddress address,
    EthereumAddress underlyingAssetAddress,
  ) : super(
          client,
          chainId,
          'aUSDC',
          address,
          UsdC(
            client,
            chainId,
            underlyingAssetAddress,
          ),
        );
}
