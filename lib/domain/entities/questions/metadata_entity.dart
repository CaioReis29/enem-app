class MetadataEntity {
  final int limit;
  final int offset;
  final int total;
  final bool hasMore;

  MetadataEntity({
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasMore,
  });
}
