class Statistics {
  int _failed = 0;
  int _successfull = 0;

  Statistics();

  void incrementSuccess() {
    _successfull += 1;
  }

  void incrementFail() {
    _failed += 1;
  }

}