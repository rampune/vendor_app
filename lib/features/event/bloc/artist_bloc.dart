
// features/artist/state/artist_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/event/model/artist_model.dart';
import 'package:new_pubup_partner/features/event/repository/artist_repository.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistRepository _repository = ArtistRepository();

  ArtistBloc() : super(ArtistInitialState()) {
    on<FetchArtistsEvent>(_onFetchArtists);
    on<AddArtistEvent>(_onAddArtist);
    on<DeleteArtistEvent>(_onDeleteArtist);
  }

  Future<void> _onFetchArtists(FetchArtistsEvent event, Emitter<ArtistState> emit) async {
    emit(ArtistLoadingState());
    try {
      final result = await _repository.getArtistData();
      if (result?.statusCode == 200) {
        final List<dynamic> rawList = result!.data['data'] ?? [];
        final List<ArtistModel> artists = rawList
            .map((json) => ArtistModel.fromJson(json as Map<String, dynamic>))
            .toList();
        emit(ArtistLoadedState(artists: artists));
      } else {
        emit(ArtistErrorState(message: result?.message ?? "Failed to load"));
      }
    } catch (e) {
      emit(ArtistErrorState(message: e.toString()));
    }
  }

  Future<void> _onAddArtist(AddArtistEvent event, Emitter<ArtistState> emit) async {
    // emit(ArtistLoadingStateLoading());
    try {
      final result = await _repository.postArtistData(
        mapData: event.data,
        imgModel: event.image,
      );

      if (result?.statusCode == 200 || result?.statusCode == 201) {
        emit(ArtistAddedSuccessState(message: "Artist added successfully!"));
        add(FetchArtistsEvent()); // ← Important: Refresh list with new server image path
      } else {
        debugPrint('Upload failed');
        emit(ArtistErrorState(message: result?.message ?? "Upload failed"));
      }
    } catch (e,stackTrace) {
      debugPrint('Exception.....$e');
      debugPrint('stackTrace.....$stackTrace');
      emit(ArtistErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteArtist(DeleteArtistEvent event, Emitter<ArtistState> emit) async {
    try {
      final result = await _repository.deleteArtist(artistId: event.artistId);
      if (result.statusCode == 200 || result.statusCode == 204) {
        emit(ArtistDeletedState(message: "Artist deleted"));
        add(FetchArtistsEvent());
      } else {
        emit(ArtistErrorState(message: "Delete failed"));
      }
    } catch (e) {
      emit(ArtistErrorState(message: e.toString()));
    }
  }
}

abstract class ArtistState extends Equatable {}

class ArtistInitialState extends ArtistState {
  @override
  List<Object?> get props => [];
}

class ArtistLoadingState extends ArtistState {
  @override
  List<Object?> get props => [];
}

class ArtistLoadedState extends ArtistState {
  final List<ArtistModel> artists;
  ArtistLoadedState({required this.artists});
  @override
  List<Object?> get props => [artists];
}

class ArtistAddedSuccessState extends ArtistState {
  final String message;
  ArtistAddedSuccessState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ArtistErrorState extends ArtistState {
  final String message;
  ArtistErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ArtistDeletedState extends ArtistState {
  final String message;
  ArtistDeletedState({required this.message});
  @override
  List<Object?> get props => [message];
}


abstract class ArtistEvent {}

class FetchArtistsEvent extends ArtistEvent {}

class AddArtistEvent extends ArtistEvent {
  final Map<String, dynamic> data;
  final ImageUploadModel image;

  AddArtistEvent({required this.data, required this.image});
}

class DeleteArtistEvent extends ArtistEvent {
  final int artistId;

  DeleteArtistEvent({required this.artistId});
}








