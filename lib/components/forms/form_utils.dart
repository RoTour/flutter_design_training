class RoFormController {
  Map<String, String> fields;
  RoFormController(this.fields);

  RoFormControl dataOf(String key) {
    return RoFormControl(this, key);
  }

  String getFieldValue(String key) {
    var result = fields[key];
    if (result == null) throw Exception("RoFormController: Provided key '$key' doesn't exist");
    return fields[key] ?? '';
  }
}

class RoFormControl {
  RoFormController controller;
  String key;

  RoFormControl(this.controller, this.key);

  void set(String newValue) {
    controller.fields[key] = newValue;
  }
}
