class Todo {
  int? id;
  int index;
  String description;
  final String added;
  String completed;

  Todo(
      {required this.id,
      required this.index,
      required this.description,
      required this.added,
      this.completed = ''});

  Todo.create(this.description, this.index)
      : id = null,
        added = DateTime.now().toIso8601String(),
        completed = '';

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idx': index,
      'description': description,
      'added': added,
      'completed': completed
    };
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  @override
  String toString() {
    return 'Todo(id: $id, index: $index, desc: $description, added: $added, completed: $completed)';
  }

  @override
  bool operator ==(Object o) =>
      identical(this, o) ||
      o is Todo &&
          (id == o.id &&
              index == o.index &&
              description == o.description &&
              added == o.added &&
              completed == o.completed);
  @override
  int get hashCode => description.hashCode;
}
