class RoMutableString {
  String _str;
  List<Function> subscribers = [];

  RoMutableString(this._str);

  get str {
    return _str;
  }

  void setStr(String newStr) {
    this._str = newStr;
    subscribers.forEach((fn) {
      fn();
    });
  }
}
