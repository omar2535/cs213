class PolyTree {
  public static void main(String[] args) {
    if (args.length > 1) {
      Node tree = null;
      for (int i=1; i < args.length; i++) {
        Node node = null;
        if (args[0].equals("i"))
          node = new IntegerNode(Integer.parseInt(args[i]));
        else if (args[0].equals("s"))
          node = new StringNode(args[i]);
        if (node != null) {
          if (tree == null)
            tree = node;
          else
            tree.insert(node);
        }
      }
      if (tree != null) {
        tree.print();
        if (args[0].equals("i")) {
          IntegerNode iTree = (IntegerNode) tree;
          System.out.printf("sum = %d\n", iTree.sum());
        }
      }
    }
  }
}
