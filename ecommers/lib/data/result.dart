class Result<TResult, TStatus> {
  final TResult data;
  final TStatus status;

  Result(this.data, this.status);

  factory Result.submit(TResult data, TStatus status) {
    return Result(data, status);
  }
}
