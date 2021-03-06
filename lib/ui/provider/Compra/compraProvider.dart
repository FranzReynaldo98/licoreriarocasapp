import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';

class CompraProvider extends ChangeNotifier{
  Compra compra=Compra.vacio();
  Compra compraCarrito=Compra.vacio();
  CompraProducto compraProducto=CompraProducto.vacio();
  void setCompra(Compra compra,{bool notificar=true}){
    this.compra=compra;
    if(notificar) notifyListeners();
  }
  void setCompraProductos(List<CompraProducto> compraProductos,{bool notificar=true}){
    this.compra.compraProductos=compraProductos;
    if(notificar) notifyListeners();
  }
  void addCompraProducto(CompraProducto compraProducto,{bool notificar=true}){
    this.compra.compraProductos.add(compraProducto);
    compra.costoTotal+=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void removeCompraProducto(CompraProducto compraProducto,{bool notificar=true}){
    this.compra.compraProductos.removeWhere((element) => element.id==compraProducto.id);
    compra.costoTotal-=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setCompraCarrito(Compra compra,{bool notificar=true}){
    this.compraCarrito=compra;
    if(notificar) notifyListeners();
  }
  void setCompraProductosCarrito(List<CompraProducto> compraProductos,{bool notificar=true}){
    this.compraCarrito.compraProductos=compraProductos;
    if(notificar) notifyListeners();
  }
  void addCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    this.compraCarrito.compraProductos.add(compraProducto);
    this.compraCarrito.compraProductos.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
    compraCarrito.costoTotal+=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void incrementarCantidadCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    if(this.compraCarrito.compraProductos.where((element) => element.producto.id==compraProducto.producto.id).length==0){
      compraProducto.cantidad++;
      this.compraCarrito.compraProductos.add(compraProducto);
      this.compraCarrito.compraProductos.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
    }else{
      compraProducto.cantidad++;
    }
    compraCarrito.costoTotal=0;
    compraCarrito.compraProductos.forEach((cp) { 
      compraCarrito.costoTotal+=cp.precioUnitario*cp.cantidad;
    });
    if(notificar) notifyListeners();
  }
  void decrementarCantidadCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    if(compraProducto.cantidad>0){
      if(compraProducto.cantidad-1==0){
        compraProducto.cantidad--;
        this.compraCarrito.compraProductos.removeWhere((element) => element.producto.id==compraProducto.producto.id);
      }else{
        compraProducto.cantidad--;
      }
      compraCarrito.costoTotal=0;
      compraCarrito.compraProductos.forEach((cp) { 
        compraCarrito.costoTotal+=cp.precioUnitario*cp.cantidad;
      });
      if(notificar) notifyListeners();
    }
  }
  void setCantidadCompraProductoCarrito(CompraProducto compraProducto,int nuevaCantidad,{bool notificar=true}){
    if(nuevaCantidad>=0){
      if(compraProducto.cantidad==0&&nuevaCantidad>0){
        compraProducto.cantidad=nuevaCantidad;
        this.compraCarrito.compraProductos.add(compraProducto);
        this.compraCarrito.compraProductos.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
      }else if(compraProducto.cantidad>0&&nuevaCantidad==0){
        compraProducto.cantidad=nuevaCantidad;
        this.compraCarrito.compraProductos.removeWhere((element) => element.producto.id==compraProducto.producto.id);
      }else{
        compraProducto.cantidad=nuevaCantidad;
      }
      compraCarrito.costoTotal=0;
      compraCarrito.compraProductos.forEach((cp) { 
        compraCarrito.costoTotal+=cp.precioUnitario*cp.cantidad;
      });
      if(notificar) notifyListeners();
    }
  }
  void removeCompraProductoCarrito(CompraProducto compraProducto,{bool notificar=true}){
    this.compraCarrito.compraProductos.removeWhere((element) => element.producto.id==compraProducto.producto.id);
    compraCarrito.costoTotal-=compraProducto.cantidad*compraProducto.precioUnitario;
    if(notificar) notifyListeners();
  }
  void setCostoTotalCarrito(List<CompraProducto> compraProductos){
    this.compraCarrito.costoTotal=0.0;
    compraProductos.forEach((element) { 
      this.compraCarrito.costoTotal+=element.cantidad*element.precioUnitario;
    });
    notifyListeners();
  }
  void notificar(){
    notifyListeners();
  }
}