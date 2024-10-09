class UnbordingContent {
  late String image;
  late String title;
  late String description;
  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent>contents=[
  UnbordingContent(image: "assets/images/screen1.png",
      title: "Select from our\n     best menu",
      description: "Pick Your Food From our Menu\n          More Than 35 times "),

  UnbordingContent(image: "assets/images/screen2.png",
      title: "Easy and Online Payment",
      description:"You can pay cash on delivery and\n        card payment is available" ),

  UnbordingContent(image: "assets/images/screen3.png",
      title: "Quick Delivery at your\n             Doorsteps",
      description: "Deliver your food at Your Doorsteps\n                    with full hygine"),
];
