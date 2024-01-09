import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/product_detail_state.dart';
import 'package:hyper_ui/bloc_util.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProductDetailController extends Cubit<ProductDetailState>
    implements IBlocBase {
  ProductDetailController() : super(ProductDetailState());

  @override
  void initState() {
    //initState event
  }

  @override
  void dispose() {
    //dispose event
  }

  @override
  void ready() {
    //ready event
  }

  increment() {
    state.counter++;
    emit(state.copyWith());
  }
}
