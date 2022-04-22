class Node {
  late String name;
  late double price;
  Node? next;
}

class IceCream {
  Node? _head;

  // creates and returns a node
  Node _createNode(String name, double price) {
    Node node = Node();
    node.name = name.toLowerCase().trim();
    node.price = price;
    node.next = null;

    return node;
  }

  IceCream() {
    _head = null;
  }

  void addItem(name, price) {
    Node node = _createNode(name, price);

    if (_head == null) {
      _head = node;
      return;
    }

    node.next = _head;
    _head = node;
  }

  void removeItem(name) {
    Node? previous = _head!;
    Node? current = _head?.next;

    String itemName = name.toLowerCase().trim();

    if (_head?.name.toLowerCase().trim() == itemName) {
      // IF FIRST THING MATCHES

      _head = current;

      return;
    }

    while (current != null) {
      if (itemName == current.name.toLowerCase().trim()) {
        previous!.next = current.next;

        return;
      }

      previous = current;
      current = current.next;
    }

  }

  bool findItem(String name) {
    Node? holdHead = _head;
    String itemName = name.toLowerCase().trim();

    while (holdHead != null && holdHead.name.toLowerCase().trim() != itemName) {
      holdHead = holdHead.next;
    }

    return (holdHead == null ? false : true);
  }

  void printItems() {
    Node? holdHead = _head;

    while (holdHead != null) {
      print("${holdHead.name} | \$${holdHead.price}");

      holdHead = holdHead.next;
    }
  }

  double getPrice(name) {
    String itemName = name.toLowerCase().trim();

    if (findItem(itemName)) {
      // IF ITEM CAN BE FOUND, FIND THE PRICE

      return _getPricePrivate(itemName, _head!);
    }

    return 0;
  }

  double _getPricePrivate(String name, Node holdHead) {
    /*if( holdHead == null ){

      return 0;
    }*/

    if (holdHead.name.toLowerCase().trim() != name) {
      // IF NAME NOT FOUND KEEP SEARCHING

      return _getPricePrivate(name, holdHead.next!);
    } else {
      return holdHead.price;
    }
  }
}
