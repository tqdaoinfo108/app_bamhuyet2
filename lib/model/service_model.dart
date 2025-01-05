class ServiceModel {
  late String image;
  late String title;

  ServiceModel(String title, String image) {
    this.image = image;
    this.title = title;
  }

  static List<ServiceModel> getServiceList() {
    return [
      ServiceModel("Bấm huyệt tại nhà", "assets/images/login.jpg"),
      ServiceModel("Massage tại nhà", "assets/images/home2.jpg"),
      ServiceModel("Chăm sóc bé tại nhà", "assets/images/home1.jpg"),
      ServiceModel("Địa điểm dịch vụ", "assets/images/home2.jpg"),
    ];
  }
}
