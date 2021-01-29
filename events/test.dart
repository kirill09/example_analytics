class TestEvent implements EventInterface {
  final String test1;
  final String test2;

  TestEvent(this.test1, this.test2) : super('eventNaem');

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'test1': test1,
      'test2': test1,
    };
  }
}
