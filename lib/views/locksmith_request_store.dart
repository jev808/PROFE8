class LocksmithRequestStore {
  static final List<Map<String, dynamic>> requests = [];

  static void add(Map<String, dynamic> request) {
    requests.add(request);
  }
}
