class IntegerNode extends Node {
  int i;

  IntegerNode(int i) {
    super();
    this.i = i;
  }

  @Override
  int compareTo(Node n) {
    IntegerNode in = (IntegerNode) n;
    if (i < in.i)
      return -1;
    else if (i > in.i)
      return 1;
    else
      return 0;
  }

  @Override
  void printNode() {
    System.out.println(i);
  }

  int sum() {
    int s = i;
    if (left != null)
      s += ((IntegerNode) left).sum();
    if (right != null)
      s += ((IntegerNode) right).sum();
    return s;
  }
}
