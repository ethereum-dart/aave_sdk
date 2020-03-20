import 'package:aave_sdk/src/addresses/mainnet.dart';
import 'package:aave_sdk/src/addresses/ropsten.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/web3dart.dart';

EthereumAddress getLendingPoolAddressesProviderAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetLendingPoolAddressesProviderAddress;
    case Network.ropsten:
      return ropstenLendingPoolAddressesProviderAddress;
    default:
      return mainnetLendingPoolAddressesProviderAddress;
  }
}

EthereumAddress getLendingPoolCoreAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetLendingPoolCoreAddress;
    case Network.ropsten:
      return ropstenLendingPoolCoreAddress;
    default:
      return mainnetLendingPoolCoreAddress;
  }
}

EthereumAddress getLendingPoolAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetLendPoolAddress;
    case Network.ropsten:
      return ropstenLendingPoolAddress;
    default:
      return mainnetLendPoolAddress;
  }
}

EthereumAddress getAEthAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAEthAddress;
    case Network.ropsten:
      return ropstenAEthAddress;
    default:
      return mainnetAEthAddress;
  }
}

EthereumAddress getADaiAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetADaiAddress;
    case Network.ropsten:
      return ropstenADaiAddress;
    default:
      return mainnetADaiAddress;
  }
}

EthereumAddress getAUsdcAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAUsdcAddress;
    case Network.ropsten:
      return ropstenAUsdcAddress;
    default:
      return mainnetAUsdcAddress;
  }
}

EthereumAddress getASynthetixUsdAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetASynthetixUsdAddress;
    case Network.ropsten:
      return ropstenASynthetixUsdAddress;
    default:
      return mainnetASynthetixUsdAddress;
  }
}

EthereumAddress getATrueUsdAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetATrueUsdAddress;
    case Network.ropsten:
      return ropstenATrueUsdAddress;
    default:
      return mainnetATrueUsdAddress;
  }
}

EthereumAddress getATetherAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetATetherAddress;
    case Network.ropsten:
      return ropstenATetherAddress;
    default:
      return mainnetATetherAddress;
  }
}

EthereumAddress getABatAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetABatAddress;
    case Network.ropsten:
      return ropstenABatAddress;
    default:
      return mainnetABatAddress;
  }
}

EthereumAddress getAKncAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAKncAddress;
    case Network.ropsten:
      return ropstenAKncAddress;
    default:
      return mainnetAKncAddress;
  }
}

EthereumAddress getALendAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetALendAddress;
    case Network.ropsten:
      return ropstenALendAddress;
    default:
      return mainnetALendAddress;
  }
}

EthereumAddress getALinkAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetALinkAddress;
    case Network.ropsten:
      return ropstenALinkAddress;
    default:
      return mainnetALinkAddress;
  }
}

EthereumAddress getAManaAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAManaAddress;
    case Network.ropsten:
      return ropstenAManaAddress;
    default:
      return mainnetAManaAddress;
  }
}

EthereumAddress getAMkrAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAMkrAddress;
    case Network.ropsten:
      return ropstenAMkrAddress;
    default:
      return mainnetAMkrAddress;
  }
}

EthereumAddress getARepAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetARepAddress;
    case Network.ropsten:
      return ropstenARepAddress;
    default:
      return mainnetARepAddress;
  }
}

EthereumAddress getASnxAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetASnxAddress;
    case Network.ropsten:
      return ropstenASnxAddress;
    default:
      return mainnetASnxAddress;
  }
}

EthereumAddress getAWBtcAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAWBtcAddress;
    case Network.ropsten:
      return ropstenAWBtcAddress;
    default:
      return mainnetAWBtcAddress;
  }
}

EthereumAddress getAZrxAddress(Network network) {
  switch (network) {
    case Network.mainnet:
      return mainnetAZrxAddress;
    case Network.ropsten:
      return ropstenAZrxAddress;
    default:
      return mainnetAZrxAddress;
  }
}
