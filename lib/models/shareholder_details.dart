enum ShareholderLocation {
  uae,
  outsideUae,
}

class ShareholderDetails {
  final String name;
  final String phone;
  final String email;
  final String placeOfBirth;
  final String nationality;
  final String? secondNationality;
  final String address;
  final ShareholderLocation location;
  final List<Document> documents;

  ShareholderDetails({
    required this.name,
    required this.phone,
    required this.email,
    required this.placeOfBirth,
    required this.nationality,
    this.secondNationality,
    required this.address,
    required this.location,
    required this.documents,
  });
}

class Document {
  final String type;
  final String url;
  final DateTime uploadDate;

  Document({
    required this.type,
    required this.url,
    required this.uploadDate,
  });
} 