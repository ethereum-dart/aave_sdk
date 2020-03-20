import 'package:aave_sdk/aave_sdk.dart';
import 'package:aave_sdk/src/a_token/a_bat.dart';
import 'package:aave_sdk/src/a_token/a_dai.dart';
import 'package:aave_sdk/src/a_token/a_eth.dart';
import 'package:aave_sdk/src/a_token/a_knc.dart';
import 'package:aave_sdk/src/a_token/a_lend.dart';
import 'package:aave_sdk/src/a_token/a_link.dart';
import 'package:aave_sdk/src/a_token/a_mana.dart';
import 'package:aave_sdk/src/a_token/a_mkr.dart';
import 'package:aave_sdk/src/a_token/a_rep.dart';
import 'package:aave_sdk/src/a_token/a_snx.dart';
import 'package:aave_sdk/src/a_token/a_synthetix_usd.dart';
import 'package:aave_sdk/src/a_token/a_tether.dart';
import 'package:aave_sdk/src/a_token/a_true_usd.dart';
import 'package:aave_sdk/src/a_token/a_usd_c.dart';
import 'package:aave_sdk/src/a_token/a_wbtc.dart';
import 'package:aave_sdk/src/a_token/a_zrx.dart';
import 'package:aave_sdk/src/addresses/get_address.dart';
import 'package:aave_sdk/src/contracts/lending_pool.dart';
import 'package:aave_sdk/src/contracts/lending_pool_core.dart';
import 'package:aave_sdk/src/contracts/lending_pool_provider.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

class AaveSdk {
  final LendingPoolAddressesProvider lendingPoolAddressesProvider;
  final LendingPoolCore lendingPoolCore;
  final LendingPool lendingPool;

  AaveSdk._(
    this.lendingPoolAddressesProvider,
    this.lendingPoolCore,
    this.lendingPool,
  );

  static Future<AaveSdk> init(
    Web3Client Function() clientFactory, {
    Network network = Network.mainnet,
  }) async {
    final chainId = getChainId(network);
    final _aEth = AEth(
      clientFactory(),
      chainId,
      getAEthAddress(network),
      getEthAddress(),
    );
    final _aDai = ADai(
      clientFactory(),
      chainId,
      getADaiAddress(network),
      getDaiAddress(network),
    );
    final _aUsdc = AUsdC(
      clientFactory(),
      chainId,
      getAUsdcAddress(network),
      getUsdcAddress(network),
    );
    final _aSynthetic = ASynthetixUsd(
      clientFactory(),
      chainId,
      getASynthetixUsdAddress(network),
      getSynthetixUsdAddress(network),
    );
    final _aTrueUsd = ATrueUsd(
      clientFactory(),
      chainId,
      getATrueUsdAddress(network),
      getTrueUsdAddress(network),
    );
    final _aTether = ATether(
      clientFactory(),
      chainId,
      getATetherAddress(network),
      getTetherAddress(network),
    );
    final _aBat = ABat(
      clientFactory(),
      chainId,
      getABatAddress(network),
      getBatAddress(network),
    );
    final _aKnc = AKnc(
      clientFactory(),
      chainId,
      getAKncAddress(network),
      getKncAddress(network),
    );
    final _aLend = ALend(
      clientFactory(),
      chainId,
      getALendAddress(network),
      getLendAddress(network),
    );
    final _aLink = ALink(
      clientFactory(),
      chainId,
      getALinkAddress(network),
      getLinkAddress(network),
    );
    final _aMana = AMana(
      clientFactory(),
      chainId,
      getAManaAddress(network),
      getManaAddress(network),
    );
    final _aMkr = AMkr(
      clientFactory(),
      chainId,
      getAMkrAddress(network),
      getMkrAddress(network),
    );
    final _aRep = ARep(
      clientFactory(),
      chainId,
      getARepAddress(network),
      getRepAddress(network),
    );
    final _aSnx = ASnx(
      clientFactory(),
      chainId,
      getASnxAddress(network),
      getSnxAddress(network),
    );
    final _aWBtc = AWBtc(
      clientFactory(),
      chainId,
      getAWBtcAddress(network),
      getWBtcAddress(network),
    );
    final _aZrx = AZrx(
      clientFactory(),
      chainId,
      getAZrxAddress(network),
      getZrxAddress(network),
    );
    final lendingPoolAddressesProvider = LendingPoolAddressesProvider(
      clientFactory(),
      getLendingPoolAddressesProviderAddress(network),
    );
    final lendingPoolAddress =
        await lendingPoolAddressesProvider.getLendingPool();

    return AaveSdk._(
      lendingPoolAddressesProvider,
      LendingPoolCore(getLendingPoolCoreAddress(network)),
      LendingPool(
        clientFactory,
        lendingPoolAddress,
        chainId,
        _aEth,
        _aDai,
        _aUsdc,
        _aSynthetic,
        _aTrueUsd,
        _aTether,
        _aBat,
        _aKnc,
        _aLend,
        _aLink,
        _aMana,
        _aMkr,
        _aRep,
        _aSnx,
        _aWBtc,
        _aZrx,
      ),
    );
  }
}
