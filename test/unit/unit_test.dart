import 'package:flutter_test/flutter_test.dart';
import 'package:endless_tic_tac_toe/constant/symbol_xo.dart';

void main() {
  test('SymbolXO enum contains X, O, empty', () {
    expect(SymbolXO.values.contains(SymbolXO.X), true);
    expect(SymbolXO.values.contains(SymbolXO.O), true);
    expect(SymbolXO.values.contains(SymbolXO.empty), true);
  });
}