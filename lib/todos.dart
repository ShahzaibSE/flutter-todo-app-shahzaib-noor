class ToDoDB {
  static List<ToDoDB> todos = [
    ToDoDB('Make Breakfast'),
    ToDoDB('Workout'),
    ToDoDB('Buy Groceries'),
    ToDoDB('Write API documentation'),
    ToDoDB('Deploy API on AWS')
  ];
  String title;
  //
  ToDoDB(this.title);
}