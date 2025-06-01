class UnavailableTimeResponse {
  final List<UnavailableDate> data;

  UnavailableTimeResponse({required this.data});

  factory UnavailableTimeResponse.fromJson(Map<String, dynamic> json) {
    return UnavailableTimeResponse(
      data: List<UnavailableDate>.from(
        json['data'].map((x) => UnavailableDate.fromJson(x)),
      ),
    );
  }
}

class UnavailableDate {
  final String fechaInicio;
  final List<HoraInicio> horaInicio;

  UnavailableDate({required this.fechaInicio, required this.horaInicio});

  factory UnavailableDate.fromJson(Map<String, dynamic> json) {
    return UnavailableDate(
      fechaInicio: json['fechaInicio'],
      horaInicio: List<HoraInicio>.from(
        json['horaInicio'].map((x) => HoraInicio.fromJson(x)),
      ),
    );
  }
}

class HoraInicio {
  final String horaInicio;

  HoraInicio({required this.horaInicio});

  factory HoraInicio.fromJson(Map<String, dynamic> json) {
    return HoraInicio(horaInicio: json['horaInicio']);
  }
}
