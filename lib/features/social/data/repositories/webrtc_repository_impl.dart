import 'package:military_hub/features/social/data/datasources/janus/janus_webrtc_repository.dart';
import 'package:military_hub/features/social/domain/repositories/webrtc_repository.dart';

class WebRTCRepositoryImpl implements WebRTCRepository {
  final JanusWebRTCRepository janusWebRTCRepository;

  WebRTCRepositoryImpl({this.janusWebRTCRepository});

  @override
  Future<int> createTransaction() async {
    var response = await janusWebRTCRepository.createTransaction();
    if (response != null) {
      return response.id;
    }
    return 0;
  }
}
