import 'package:aave_sdk/src/contracts/a_token.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class AMkr extends AToken {
  AMkr(
    Web3Client client,
    int chainId,
    EthereumAddress address,
    EthereumAddress underlyingAssetAddress,
  ) : super(
          client,
          chainId,
          'aMKR',
          address,
          Mkr(
            client,
            chainId,
            underlyingAssetAddress,
          ),
        );
}
