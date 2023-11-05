class Review {
  int reviewID;
  int rating;
  String text;
  String photo;
  int appointmentID;

  Review({
    required this.reviewID,
    required this.rating,
    required this.text,
    required this.appointmentID,
    this.photo = '',
  });
}
