String current_donate(int amount) {
  if (amount == 0)
    return "0";
  else {
    return amount.toString() + "000";
  }
}
