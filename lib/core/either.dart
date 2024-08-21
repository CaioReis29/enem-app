
// class Either<L, R> {
//   final L left;
//   final R right;

//   Either(this.left, this.right);

//   bool get isLeft => left != null;

//   bool get isRight => right != null;

//   L getLeft() {
//     if(isLeft) {
//       return left;
//     } else {
//       throw Exception("Left is null");
//     }
//   }

//   R getRight() {
//     if(isRight) {
//       return right;
//     } else {
//       throw Exception("Right is null");
//     }
//   }

//   @override
//   bool operator ==(Object other) =>
//     identical(this, other) ||
//       other is Either &&
//       runtimeType == other.runtimeType &&
//       left == other.left &&
//       right == other.right;

//   @override
//   int get hashCode => left.hashCode ^ right.hashCode;

//   copyWith({required L left, required R right}) => 
//     Either(left ?? this.left, right ?? this.right);

//   @override
//   String toString() {
//     return "Either: $left, right: $right";
//   }

//   Either<L, R> setLeft(L left) {
//     return Either(left, right);
//   }

//   Either<L, R> setRight(R right) {
//     return Either(left, right);
//   }
  
// }

// class Left<L> extends Either<L, Null> {
//   Left(L left) : super(left, null);
//   get value => super.left;

//   @override
//   String toString() {
//     return "Left{left: $left}";
//   }
// }

// class Right<R> extends Either<Null, R> {
//   Right(R right) : super(null, right);
//   get value => super.right;

//   @override
//   String toString() {
//     return "Right{Right: $right}";
//   }
// }