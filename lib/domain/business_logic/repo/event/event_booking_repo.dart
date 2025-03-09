import 'package:glint_frontend/utils/network_response.dart';

abstract class EventBookingRepo {
  Future<NetworkResponse<void>> getUserTickets();

  Future<NetworkResponse<void>> bookEvent();
}
