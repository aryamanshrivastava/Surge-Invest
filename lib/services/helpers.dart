class Helpers {
  int invested(int amount) {
    int invested, rounded;
    if (amount < 100) {
      if (amount % 5 == 0) {
        invested = 5;
      } else {
        rounded = (amount / 5).ceil() * 5;
        invested = rounded - amount;
      }
    } else {
      if (amount % 10 == 0) {
        invested = 10;
      } else {
        rounded = (amount / 10).ceil() * 10;
        invested = rounded - amount;
      }
    }
    return invested;
  }
  
}
