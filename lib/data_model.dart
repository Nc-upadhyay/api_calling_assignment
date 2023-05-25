class DataModel {
  final int storyId;
  final String couplePhoto;
  final String coupleName;
  final String story;

  DataModel(this.coupleName, this.couplePhoto, this.storyId, this.story);

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(json["CoupleName"], json["CouplePhotoImageUrl"],
        json["StoryId"], json["Story"]);
  }
}
