class AppDownMaster {
  bool? appDown;
  String? appDownMessage;
  String? appDownHeader;
  String? appDownImageUrl;

  AppDownMaster(
      {this.appDown,
        this.appDownMessage,
        this.appDownHeader,
        this.appDownImageUrl});

  AppDownMaster.fromJson(Map<String, dynamic> json) {
    appDown = json['app_down'];
    appDownMessage = json['app_down_message'];
    appDownHeader = json['app_down_header'];
    appDownImageUrl = json['app_down_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_down'] = appDown;
    data['app_down_message'] = appDownMessage;
    data['app_down_header'] = appDownHeader;
    data['app_down_image_url'] = appDownImageUrl;
    return data;
  }
}
