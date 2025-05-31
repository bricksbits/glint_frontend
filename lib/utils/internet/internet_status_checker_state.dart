part of 'internet_status_checker_cubit.dart';

@immutable
sealed class InternetStatusCheckerState {}

final class InternetStatusConnected extends InternetStatusCheckerState {}
final class InternetStatusDisConnected extends InternetStatusCheckerState {}
