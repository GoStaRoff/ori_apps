import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class OriApi {
  static Dio dio = new Dio(
    BaseOptions(
      baseUrl: "https://dncompany.fun",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  static testRequest() async {}

  //--------------------------Пользователи--------------------------------

  static Future<Response> registration(
      String email, String password, bool licensePP, bool licenseUA) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "registration",
          "email": email,
          "password": password,
          "license_pp": licensePP,
          "license_ua": licenseUA,
        },
      ),
    );
    return response;
  }

  static Future<Response> socialAuth(
      String email, String login, String urlAvatar) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "social_auth",
          "login": login,
          "email": email,
          "url_avatar": urlAvatar,
        },
      ),
    );
    return response;
  }

  static Future<Response> login(String email, String password) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "login",
          "email": email,
          "password": password,
        },
      ),
    );
    return response;
  }

  static Future<Response> setDefaultAvatar(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_default_avatar",
          "client_id": clientId,
        },
      ),
    );
    return response;
  }

  static Future<Response> setAvatar(int clientId, File clientAvatar) async {
    var response;
    var avatar = new MultipartFile.fromBytes(
      clientAvatar.readAsBytesSync(),
      filename: clientAvatar.path.split("/").last,
      contentType: MediaType(
        'image',
        'jpg',
      ),
    );
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_avatar",
          "client_id": clientId,
          "client_avatar[]": avatar,
        },
      ),
    );
    return response;
  }

  static Future<Response> setSettings(
      int clientId, String currency, String measure, String language) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_settings",
          "client_id": clientId,
          "currency": currency,
          "measure": measure,
          "language": language,
        },
      ),
    );
    return response;
  }

  static Future<Response> setPersonalInfo(
      int clientId, String year, String gender) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_personal_info",
          "client_id": clientId,
          "year": year,
          "gender": gender,
        },
      ),
    );
    return response;
  }

  static Future<Response> getClientInfo(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_client_info",
          "client_id": clientId,
        },
      ),
    );
    return response;
  }

  static Future<Response> setPaymentAddress(
      int clientId, int paymentAddress) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_payment_address",
          "id": clientId,
          "payment": paymentAddress,
        },
      ),
    );
    return response;
  }

  //--------------------------Лицензия--------------------------------

  static Future<Response> getLicense() async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_license",
        },
      ),
    );
    return response;
  }

  static Future<Response> checkLicense(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "check_license",
          "client_id": clientId,
        },
      ),
    );
    return response;
  }

  //--------------------------Wishlist--------------------------------

  static sendWish(int clientId, String wishText, List<File> wishFiles) async {
    var response;
    var formData;
    List<MultipartFile> multipartImageList = [];
    if (wishFiles.isNotEmpty) {
      wishFiles.forEach(
        (element) {
          var multipartFile = new MultipartFile.fromBytes(
            element.readAsBytesSync(),
            filename: element.path.split("/").last,
            contentType: MediaType(
              'image',
              'jpg',
            ),
          );
          multipartImageList.add(multipartFile);
        },
      );
      formData = FormData.fromMap(
        {
          "type": "send_wish",
          "client_id": clientId,
          "wish_text": wishText,
          "wish_files[]": multipartImageList,
        },
      );
    } else {
      formData = FormData.fromMap(
        {
          "type": "send_wish",
          "client_id": clientId,
          "wish_text": wishText,
        },
      );
    }
    try {
      response = await dio.post("/api/api.php", data: formData);
    } catch (e) {}
    return response;
  }

  //--------------------------PUSH-уведомления--------------------------------

  static Future<Response> pushNotifications(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {"type": "push_notifications_by_client", "client_id": clientId},
      ),
    );
    return response;
  }

  static Future<Response> notifReaded(int clientId, int notifId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "notif_readed",
          "client_id": clientId,
          "notif_id": notifId,
        },
      ),
    );
    return response;
  }

  static Future<Response> getCoachRoutes(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_coach_routes",
          "id": clientId,
        },
      ),
    );
    return response;
  }

  static Future<Response> searchCoachRoutes(
      int clientId, String searchText) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "search_coach_routes",
          "id": clientId,
          "text": searchText,
        },
      ),
    );
    return response;
  }

  static Future<Response> searchAthleteRoutes(
      int clientId, String searchText) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "search_athlete_routes",
          "id": clientId,
          "text": searchText,
        },
      ),
    );
    return response;
  }

  static Future<Response> getArs() async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_ars",
        },
      ),
    );
    return response;
  }

  static Future<Response> getAr(int arId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_ar",
          "id": arId,
        },
      ),
    );
    return response;
  }

  static Future<Response> getRoute(int clientId, String routeId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {"type": "get_route", "route_id": routeId, "id": clientId},
      ),
    );
    return response;
  }

//--------------------------Тарифы--------------------------------
  static Future<Response> getTariff() async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_tariff_coach",
        },
      ),
    );
    return response;
  }

  static Future<Response> setTariff(
      int clientId, String tariffName, int monthCount) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_tariff_coach",
          "client_id": clientId,
          "tariff_name": tariffName,
          "tariff_month": monthCount,
        },
      ),
    );
    return response;
  }

//--------------------------Контрольные точки--------------------------------
  static Future<Response> getPoints(int clientId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "get_points",
          "client_id": clientId,
        },
      ),
    );
    return response;
  }

  static Future<Response> setPoint(
    int clientId,
    double latitude,
    double longitude,
    var photo,
    String arId,
  ) async {
    var response;
    var _photo;
    if (photo != null) {
      _photo = new MultipartFile.fromBytes(
        photo,
        filename: "pointPhoto$latitude",
      );
    }
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "set_point",
          "client_id": clientId,
          "latitude": latitude,
          "longitude": longitude,
          "photo[]": _photo,
          "ar_id": arId,
        },
      ),
    );
    return response;
  }

  static Future<Response> delPoint(String name) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "del_point",
          "name": name,
        },
      ),
    );
    print(response);
    return response;
  }

  static Future<Response> addComment(
      int routeId, int clientId, String text) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "add_comment",
          "route_id": routeId,
          "client_id": clientId,
          "text": text,
          "rate": 5,
        },
      ),
    );
    return response;
  }

  static Future<Response> deleteComment(int commentId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "delete_comment",
          "comment_id": commentId,
        },
      ),
    );
    return response;
  }

  static Future<Response> deleteRoute(int routeId) async {
    var response;
    response = await dio.post(
      "/api/api.php",
      data: FormData.fromMap(
        {
          "type": "delete_route",
          "route_id": routeId,
        },
      ),
    );
    return response;
  }

  static createRoute(
    int clientId,
    String routeName,
    String routeDescription,
    String routeOpen,
    String routeType,
    String routeTheme,
    String routeMethod,
    String routeTerra,
    int routePenalty,
    int routePrice,
    String routeAvatar,
    String mapImage,
    String startPositionX,
    String startPositionY,
    int mapScale,
    var cps,
    var transitions,
  ) async {
    List<File> wishFiles = [];
    var response;
    var formData;
    List<MultipartFile> multipartImageList = [];

    if (routeType == "Quest") {
      for (var i = 0; i < transitions.length; i++) {
        transitions[i]["avatar"] = new MultipartFile.fromBytes(
          File(transitions[i]["avatar"]).readAsBytesSync(),
          filename: File(transitions[i]["avatar"]).path.split("/").last,
        );
        if (transitions[i]["sound"].length > 0) {
          transitions[i]["sound"] = new MultipartFile.fromBytes(
            File(transitions[i]["sound"]).readAsBytesSync(),
            filename: File(transitions[i]["sound"]).path.split("/").last,
          );
        }
      }
    }

    if (routeType == "Detective") {
      for (var i = 0; i < transitions.length; i++) {
        cps[i]["avatar"] = new MultipartFile.fromBytes(
          File(cps[i]["avatar"]).readAsBytesSync(),
          filename: File(cps[i]["avatar"]).path.split("/").last,
        );
        if (cps[i]["sound"] != null && cps[i]["sound"].length > 0) {
          cps[i]["sound"] = new MultipartFile.fromBytes(
            File(cps[i]["sound"]).readAsBytesSync(),
            filename: File(cps[i]["sound"]).path.split("/").last,
          );
        } else {
          cps[i]["sound"] = "";
        }
      }
    }

    wishFiles.forEach(
      (element) {
        var multipartFile = new MultipartFile.fromBytes(
          element.readAsBytesSync(),
          filename: element.path.split("/").last,
          contentType: MediaType(
            'image',
            'jpg',
          ),
        );
        multipartImageList.add(multipartFile);
      },
    );

    File _avatar = File(routeAvatar);
    var avatar = new MultipartFile.fromBytes(
      _avatar.readAsBytesSync(),
      filename: _avatar.path.split("/").last,
      contentType: MediaType(
        'image',
        'jpg',
      ),
    );

    var map;
    if (mapImage.length > 1) {
      File _map = File(mapImage);
      map = new MultipartFile.fromBytes(
        _map.readAsBytesSync(),
        filename: _map.path.split("/").last,
        contentType: MediaType(
          'image',
          'jpg',
        ),
      );
    } else {
      map = null;
    }
    formData = FormData.fromMap(
      {
        "type": "create_route",
        "client_id": clientId,
        "route_name": routeName,
        "route_desciption": routeDescription,
        "route_oc": routeOpen,
        "route_type": routeType,
        "route_theme": routeTheme,
        "route_method": routeMethod,
        "route_terra": routeTerra,
        "route_penalty": routePenalty,
        "route_price": routePrice,
        "route_avatar[]": avatar, //TODO route avatar bytes
        "start_position_x": startPositionX,
        "start_position_y": startPositionY,
        "map_scale": mapScale,
        "map_image[]": map, //TODO map image bytes
        "cps": cps, //TODO cps
        "transitions": transitions, //TODO transitions
      },
    );
    try {
      response = await dio.post("/api/api.php", data: formData);
    } catch (e) {}
    return response;
  }
}
