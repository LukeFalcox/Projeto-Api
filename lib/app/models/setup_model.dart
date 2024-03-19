// ignore_for_file: unnecessary_this

class SetupModel {
  String? name;
  String? userID;
  String? token;
  String? endpoint;
  int? theme;
  bool? showLogHistory;
  String? empresa;
  String? filial;
  String? welcome;
  String? loginBackgroundImageUrl;
  String? logologin;
  String? logomenu;
  String? picture;
  Map<String, dynamic>? menu;
  // List? menuV2;

  
  SetupModel({
    this.userID,
    this.token,
    this.endpoint,
    this.name,
    this.theme,
    this.showLogHistory,
    this.empresa,
    this.filial,
    this.welcome,
    this.loginBackgroundImageUrl,
    this.logologin,
    this.logomenu,
    this.picture,
    this.menu,
  });

  factory SetupModel.fromJson(Map<String, dynamic> json) {
    return SetupModel(
      name: json['name'],
      userID: json['userID'],
      token: json['Token'],
      endpoint: json['endpoint'],
      theme: json['theme'],
      showLogHistory: json['showLogHistory'],
      empresa: json['empresa'],
      filial: json['filial'],
      welcome: json['welcome'],
      loginBackgroundImageUrl: json['loginBackgroundImageUrl'],
      logologin: json['logologin'],
      logomenu: json['logomenu'],
      picture: json['picture'],
      menu: json['Menu'],
      // menuV2: json['MenuV2'] != null ? Menu.fromJson(json['MenuV2']) : null,
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'userID': this.userID,
      'Token': this.token,
      'endpoint': this.endpoint,
      'theme': this.theme,
      'showLogHistory': this.showLogHistory,
      'empresa': this.empresa,
      'filial': this.filial,
      'welcome': this.welcome,
      'loginBackgroundImageUrl': this.loginBackgroundImageUrl,
      'logologin': this.logologin,
      'logomenu': this.logomenu,
      'picture': this.picture,
      'Menu': this.menu,
    };
  }

}

 

