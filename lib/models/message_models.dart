
import 'dart:convert';

LocationRequestMessage locationRequestMessageFromJson(String str) => LocationRequestMessage.longitudeJson(json.decode(str));

String locationRequestMessageToJson(LocationRequestMessage data) => json.encode(data.toJson());

class LocationRequestMessage {
    final double latitude;
    final double longitude;

    LocationRequestMessage({
        required this.latitude,
        required this.longitude,
    });

    factory LocationRequestMessage.longitudeJson(Map<double, dynamic> json) => LocationRequestMessage(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
