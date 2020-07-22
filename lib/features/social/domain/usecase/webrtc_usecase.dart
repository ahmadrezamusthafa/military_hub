import 'package:military_hub/features/social/domain/repositories/webrtc_repository.dart';

class WebRTCUseCase {
  final WebRTCRepository repository;

  WebRTCUseCase(this.repository);

  Future<int> createTransaction() async {
    return repository.createTransaction();
  }
}
