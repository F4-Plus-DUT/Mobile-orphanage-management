extension StringExtension on String {
  String capitalize() {
    if (this.length == 0) return "";
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
