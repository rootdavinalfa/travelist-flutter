class TravelList {
  int id;
  String title;
  String imgURL;
  String description;
  String location;

  TravelList(
      {required this.id,
      required this.title,
      this.imgURL = "",
      required this.description,
      required this.location});
}
