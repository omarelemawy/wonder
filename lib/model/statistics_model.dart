class StatisticsModel {
  int users;
  int events;
  int tickets;
  int sponsers;

  StatisticsModel({this.users, this.events, this.tickets, this.sponsers});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    users = json['users'];
    events = json['events'];
    tickets = json['tickets'];
    sponsers = json['sponsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users'] = this.users;
    data['events'] = this.events;
    data['tickets'] = this.tickets;
    data['sponsers'] = this.sponsers;
    return data;
  }
}