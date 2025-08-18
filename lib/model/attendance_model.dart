class AttendanceModel {
  final String status;
  final String message;
  final int reportId;
  final int userId;
  final String createdAt;

  AttendanceModel({
    required this.status,
    required this.message,
    required this.reportId,
    required this.userId,
    required this.createdAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      reportId: json['report_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: json['attendance'] != null
          ? json['attendance']['created_at'] ?? ''
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'report_id': reportId,
      'user_id': userId,
      'attendance': {
        'created_at': createdAt,
      },
    };
  }
}
