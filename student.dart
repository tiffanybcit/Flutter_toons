class Student {
  final int personId;
  final String firstName;
  final String lastName;
  final String occupation;
  final String gender;
  final String pictureURL;
  final int votes;

  Student(this.personId, this.firstName, this.lastName, this.occupation, this.gender, this.pictureURL, this.votes);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['id'],
      json['firstName'],
      json['lastName'],
      json['occupation'],
      json['gender'],
      json['pictureUrl'],
      json['votes']

    );
  }
}