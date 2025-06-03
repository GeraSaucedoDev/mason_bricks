class ReportedError {
  final dynamic originalError;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? data;
  
  const ReportedError(this.originalError, [this.stackTrace, this.data]);
  
  @override
  String toString() => originalError.toString();
}