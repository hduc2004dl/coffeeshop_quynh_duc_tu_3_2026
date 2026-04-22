class GenericsClass<T> {
  T obj;
  GenericsClass(this.obj);
  void printData() {
    print('Danh sách sinh viên');
    if (obj is List) {
      for (var item in obj as List) {
        print(item);
      }
    } else {
      print(obj);
    }
  }
}

void main() {
  var student = [
    {'studentID': 's19010025', 'fullname': 'Nguyen Van Quynh'},
    {'studentID': 's22010054', 'fullname': 'Nguyen Hoang Duc'},
    {'studentID': 's23010312', 'fullname': 'Nguyen Van Tu'},
  ];
  var myData = GenericsClass<List<Map<String, String>>>(student);
  myData.printData();
}
