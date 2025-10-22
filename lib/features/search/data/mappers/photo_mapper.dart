import '../../domain/entities/photo.dart';
import '../models/photo_model.dart';

extension PhotoModelX on PhotoModel {
  Photo toEntity() => Photo(
    id: id,
    thumbUrl: small,
    fullUrl: regular,
    title: alt.isEmpty ? 'Sin título' : alt,
    author: author,
  );
}
