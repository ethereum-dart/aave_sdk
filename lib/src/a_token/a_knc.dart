import 'package:aave_sdk/src/contracts/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class AKnc extends AToken {
  AKnc(
    Web3Client client,
    int chainId,
    EthereumAddress address,
    EthereumAddress underlyingAssetAddress,
  ) : super(
          client,
          chainId,
          'aKNC',
          address,
          Knc(
            client,
            chainId,
            underlyingAssetAddress,
          ),
        );
}
