import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';

abstract class AbstractProveedorRepository{
  Future<Map<String,dynamic>> registrarProveedor(Proveedor proveedor);
  Future<bool> modificarProveedor(Proveedor proveedor);
  Future<bool> eliminarProveedor(String id);
  Future<Map<String,dynamic>> obtenerProveedores();
  Future<Map<String,dynamic>> buscarProveedor(String ciNit,String nombres);
}

abstract class AbstractCompraReposity{
  Future<Map<String,dynamic>> registrarPreCompra(Compra compra);
  Future<bool> modificarPreCompra(Compra compra);
  Future<bool> terminarPreCompra(Compra compra);
  Future<Map<String,dynamic>> obtenerPreComprasPendientes(String idSucursal,String tipoUsuarioConfirmacion);
  Future<Map<String,dynamic>> responderConfirmacionPreCompra(Compra compra);
}

abstract class AbstractCompraProductoRepository{
  Future<Map<String,dynamic>> registrarCompraProducto(String idCompra,double costoTotal,CompraProducto compraProducto);
}
 
