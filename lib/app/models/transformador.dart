class FiltroModel {
  String idDart;
  String apiTrigger;
  String cabecalho;
  double spaceBetweenFields;
  String apiBusca;
  List<CampoModel> campos;

  FiltroModel({
    required this.idDart,
    required this.apiTrigger,
    required this.cabecalho,
    required this.spaceBetweenFields,
    required this.apiBusca,
    required this.campos,
  });

  factory FiltroModel.fromJson(Map<String, dynamic> json) {
    return FiltroModel(
      idDart: json['id_dart'] ?? '',
      apiTrigger: json['apitrigger'] ?? '',
      cabecalho: json['cabecalho'] ?? '',
      spaceBetweenFields: json['spaceBetweenFields'] ?? 0.0,
      apiBusca: json['apibusca'] ?? '',
      campos: (json['campos'] as List<dynamic>?)
              ?.map((campo) => CampoModel.fromJson(campo))
              .toList() ??
          [],
    );
  }
}

class CampoModel {
  String id;
  String titulo;
  String tipo;
  bool expanded;
  bool trigger;
  String padrao;
  int tamanho;
  bool editavel;
  bool obrigatorio;
  MascaraModel? mascara;
  String? apiSearch;
  String? value;
  String? color;
  int? height;
  int? topDistance;
  int? bottomDistance;
  bool? bold;
  int? size;

  CampoModel({
    required this.id,
    required this.titulo,
    required this.tipo,
    required this.expanded,
    required this.trigger,
    required this.padrao,
    required this.tamanho,
    required this.editavel,
    required this.obrigatorio,
    this.mascara,
    this.apiSearch,
    this.value,
    this.color,
    this.height,
    this.topDistance,
    this.bottomDistance,
    this.bold,
    this.size,
  });

  factory CampoModel.fromJson(Map<String, dynamic> json) {
    return CampoModel(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      tipo: json['tipo'] ?? '',
      expanded: json['expanded'] ?? false,
      trigger: json['trigger'] ?? false,
      padrao: json['padrao'] ?? '',
      tamanho: json['tamanho'] ?? 0,
      editavel: json['editavel'] ?? false,
      obrigatorio: json['obrigatorio'] ?? false,
      mascara: json['mascara'] != null ? MascaraModel.fromJson(json['mascara']) : null,
      apiSearch: json['apisearch'],
      value: json['value'],
      color: json['color'],
      height: json['height'],
      topDistance: json['topDistance'],
      bottomDistance: json['bottomDistance'],
      bold: json['bold'],
      size: json['size'],
    );
  }
}

class MascaraModel {
  String formato;
  Map<String, String> filtros;

  MascaraModel({
    required this.formato,
    required this.filtros,
  });

  factory MascaraModel.fromJson(Map<String, dynamic> json) {
    return MascaraModel(
      formato: json['formato'] ?? '',
      filtros: (json['filtros'] as Map<String, dynamic>?)?.cast<String, String>() ?? {},
    );
  }
}