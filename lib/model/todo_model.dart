class Todo {
  final int id;
  final String title;
  final String description;
  final String time;
  final int favorite;
  final int completed;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.time,
      required this.favorite,
      required this.completed});

  // todo nesnesini entity dönüştürme
  factory Todo.fromJSON(Map<String, dynamic> record) {
    // databaseden çekilecek veri
    return Todo(
        id: record["id"],
        title: record["title"],
        description: record["description"],
        time: record["time"],
        favorite: record["favorite"],
        completed: record["completed"]);
  }

  @override
  String toString() {
    return "ID: $id\n Title: $title\n Description: $description\n Time: $time Favourite: $favorite\n Completed: $completed";
  }
}
