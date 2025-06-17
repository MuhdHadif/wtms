class Submission {
  String? id;
  String? workId;
  String? workerId;
  String? submissionText;
  String? submittedAt;
  String? title;

  Submission(
      {this.id,
      this.workId,
      this.workerId,
      this.submissionText,
      this.submittedAt,
      this.title});

  Submission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workId = json['workId'];
    workerId = json['workerId'];
    submissionText = json['submissionText'];
    submittedAt = json['submittedAt'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['workId'] = workId;
    data['workerId'] = workerId;
    data['submissionText'] = submissionText;
    data['submittedAt'] = submittedAt;
    data['title'] = title;
    return data;
  }
}