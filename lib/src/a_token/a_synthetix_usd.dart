import 'package:aave_sdk/src/contracts/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class ASynthetixUsd extends AToken {
  ASynthetixUsd(
    Web3Client client,
    int chainId,
    EthereumAddress address,
    EthereumAddress underlyingAssetAddress,
  ) : super(
          client,
          chainId,
          'aSUSD',
          address,
          SynthetixUsd(
            client,
            chainId,
            underlyingAssetAddress,
          ),
        );
}
