class Work {
  String? id;
  String? title;
  String? description;
  String? assignedTo;
  String? dateAssigned;
  String? dueDate;
  String? status;

  Work(
      {this.id,
      this.title,
      this.description,
      this.assignedTo,
      this.dateAssigned,
      this.dueDate,
      this.status});

  Work.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    assignedTo = json['assignedTo'];
    dateAssigned = json['dateAssigned'];
    dueDate = json['dueDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['assignedTo'] = this.assignedTo;
    data['dateAssigned'] = this.dateAssigned;
    data['dueDate'] = this.dueDate;
    data['status'] = this.status;
    return data;
  }
}