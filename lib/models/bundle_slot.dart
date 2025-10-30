class BundleSlot {
  final String id;
  final int row;
  final int col;
  final int rowSpan;
  final int colSpan;

  const BundleSlot({
    required this.id,
    required this.row,
    required this.col,
    this.rowSpan = 1,
    this.colSpan = 1,
  });
}
