public abstract class Node {
  Node left, right;

  Node() {
    left  = null;
    right = null;
  }

  abstract int compareTo(Node n);

  abstract void printNode();

  void insert(Node node) {
    int c = compareTo(node);
    if (c > 0) {
      if (left == null)
        left = node;
      else
        left.insert(node);
    } else if (c < 0) {
      if (right == null)
        right = node;
      else
        right.insert(node);
    }
  }

  void print() {
    if (left != null)
      left.print();
    printNode();
    if (right != null)
      right.print();
  }
}

