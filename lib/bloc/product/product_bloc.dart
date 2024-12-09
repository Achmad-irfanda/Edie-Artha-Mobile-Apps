import 'package:bloc/bloc.dart';
import 'package:eam_app/data/datasource/product_remote_datasource.dart';
import 'package:eam_app/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(_Initial()) {
    // Get All
    on<_Product>((event, emit) async {
      emit(_Loading());
      final result = await ProductRemoteDatasource().product();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    // Searching
    on<_GetProduct>((event, emit) async {
      emit(_Loading());
      final result = await ProductRemoteDatasource().getProduct(event.query);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
