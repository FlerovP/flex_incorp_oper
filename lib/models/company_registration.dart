enum RegistrationStatus {
  new_,
  inProgress,
  completed,
  rejected
}

class CompanyRegistration {
  final String id;
  final String companyName;
  final String clientName;
  final String email;
  final String phone;
  final String freezone;
  final DateTime submissionDate;
  RegistrationStatus status;
  final String? notes;
  final List<String>? documents;

  CompanyRegistration({
    required this.id,
    required this.companyName,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.freezone,
    required this.submissionDate,
    this.status = RegistrationStatus.new_,
    this.notes,
    this.documents,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'clientName': clientName,
      'email': email,
      'phone': phone,
      'freezone': freezone,
      'submissionDate': submissionDate.toIso8601String(),
      'status': status.toString(),
      'notes': notes,
      'documents': documents,
    };
  }

  factory CompanyRegistration.fromJson(Map<String, dynamic> json) {
    return CompanyRegistration(
      id: json['id'],
      companyName: json['companyName'],
      clientName: json['clientName'],
      email: json['email'],
      phone: json['phone'],
      freezone: json['freezone'],
      submissionDate: DateTime.parse(json['submissionDate']),
      status: RegistrationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      notes: json['notes'],
      documents: json['documents']?.cast<String>(),
    );
  }
} 