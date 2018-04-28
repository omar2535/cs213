class StringNode extends Node {
  String s;

  StringNode(String s) {
    super();
    this.s = s;;
  }

  @Override
  int compareTo(Node n) {
    StringNode sn = (StringNode) n;
    return s.compareTo(sn.s);
  }

  @Override
  void printNode() {
    System.out.println(s);
  }
}
