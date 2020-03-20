enum InterestRateMode {
  none,
  stable,
  variable,
}

InterestRateMode deserializeInterestRateMode(int value) {
  switch (value) {
    case 0:
      return InterestRateMode.none;
    case 1:
      return InterestRateMode.stable;
    case 2:
      return InterestRateMode.variable;
    default:
      return InterestRateMode.none;
  }
}
