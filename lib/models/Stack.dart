class Stack {
  final String name;
  final Map<String,int> order;

  Stack(this.name, this.order);

  Stack.fromJson(Map<String, dynamic> json) 
      : name = json['name'],
      order = json['order'];
}