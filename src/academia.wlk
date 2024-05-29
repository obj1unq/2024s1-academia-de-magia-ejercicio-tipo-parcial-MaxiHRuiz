class Academia {
	var property muebles = #{}

	method contieneElemento(cosa) {
		return muebles.any{m => m.tiene(cosa)}
	}
	
	method guardarElemento(cosa){
		if(not self.puedeGuardar(cosa)){
			self.error("el elemento nose puede guardar en la academia")
		}
		
		self.muebleDondeGuardar(cosa).anyOne().guardar(cosa)
	}
	
	method puedeGuardar(cosa){
		return not self.contieneElemento(cosa) && self.existeMuebleDondeGuardar(cosa)
	}
	
	method existeMuebleDondeGuardar(cosa){
		return muebles.any{m => m.puedeGuardar(cosa)}
	}
	
	method muebleDondeGuardar(cosa){
		return muebles.filter{m => m.puedeGuardar(cosa)}
	}

}

class Armario inherits Mueble {

	var property cantidadMaxima
	
	override method puedeGuardar(cosa){
		return super(cosa) && self.cantidadDeCosasGuardadas() < cantidadMaxima
	}
	
	override method precio(){
		return cantidadMaxima * 5
	}

}

class GabineteMagico inherits Mueble {
	var property precio = 0
	
	override method puedeGuardar(cosa){
		return super(cosa) && cosa.esMagico()
	}
	
	
	override method precio(){
		return precio
	}
}


class BaulMagico inherits Baul {
	override method utilidad(){
		return super() + self.sumar1SiEsMagico()
	}
	
	method sumar1SiEsMagico(){
		return cosas.count({cosa => cosa.esMagico()})   
	}
	
	override method precio(){
		return super() *2
	}
}

class Baul inherits Mueble {

	var property volumenMaximo
	
	override method puedeGuardar(cosa){
		return super(cosa) && (cosa.volumen() + self.pesoTotalDeCosasGuardadas() <= volumenMaximo)
	}
	
	override method precio(){
		return volumenMaximo + 2
	}
	
	override method utilidad(){
		return super() + self.sumar2SiSonReliquias()
	}
	
	method sumar2SiSonReliquias(){
		return if (cosas.all{c => c.esReliquia()}) 2 else 0
	}
}

class Mueble {

	const cosas = #{}

	method pesoTotalDeCosasGuardadas() {
		return cosas.sum{ c => c.volumen() }
	}

	method cantidadDeCosasGuardadas() {
		return cosas.size()
	}

	method guardar(cosa) {
		self.validarCosa(cosa)
		cosas.add(cosa)
	}
	
	method tiene(cosa){
		return cosas.contains(cosa)
	}
	
	method puedeGuardar(cosa){
		return not self.tiene(cosa)
	}

	method validarCosa(cosa){
		if (not self.puedeGuardar(cosa)){
			self.error("no se puede guardar la cosa")
		}
	}
	
	method utilidad(){
		console.println(cosas.sum{c => c.utilidad()} / self.precio())
		
		return cosas.sum{c => c.utilidad()} / self.precio()
	}
	
	method precio()
}

class Cosa {

	var property marca
	var property volumen
	var property esMagico
	var property esReliquia
	
	
	method utilidad(){
		return volumen + self.utilidadSiMagica() + self.utilidadSiReliquia() + marca.utilidad(self)
	}
	
	method utilidadSiMagica() {
		return if (esMagico) 3 else 0
	}
	
	method utilidadSiReliquia() {
		return if (esReliquia) 5 else 0
	}

}

object acme {
	method utilidad(cosa){
		return cosa.volumen() / 2
	}
}

object fenix  {
	method utilidad(cosa){
		return if (cosa.esReliquia()) 3 else 0
	}
}

object cuchuflito {
	method utilidad(cosa){
		return 0
	}
}

