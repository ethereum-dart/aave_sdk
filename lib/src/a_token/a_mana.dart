import 'package:aave_sdk/src/contracts/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class AMana extends AToken {
  AMana(
    Web3Client client,
    int chainId,
    EthereumAddress address,
    EthereumAddress underlyingAssetAddress,
  ) : super(
          client,
          chainId,
          'aMANA',
          address,
          Mana(
            client,
            chainId,
            underlyingAssetAddress,
          ),
        );
}
