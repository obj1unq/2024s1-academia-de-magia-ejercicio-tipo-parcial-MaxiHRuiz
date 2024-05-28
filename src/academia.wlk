class Academia {
	var property muebles = []

	method contieneElemento(cosa) {
		return muebles.any{m => m.tiene(cosa)}
	}
	
	method guardarElemento(cosa){
		if(self.puedeGuardar(cosa)){
			self.error("el elemento nose puede guardar en la academia")
		}
		
		self.muebleDondeGuardar(cosa).guardar(cosa)
	}
	
	method puedeGuardar(cosa){
		//console.println(self.contieneElemento(cosa))
		return not self.contieneElemento(cosa) && self.existeMuebleDondeGuardar(cosa)
	}
	
	method existeMuebleDondeGuardar(cosa){
		return muebles.any{m => m.puedeGuardar(cosa)}
	}
	
	method muebleDondeGuardar(cosa){
		return muebles.find{m => m.puedeGuardar(cosa)}
	}

}

class Armario inherits Mueble {

	var property cantidadMaxima
	
	override method puedeGuardar(cosa){
		return super(cosa) && self.cantidadDeCosasGuardadas() < cantidadMaxima
	}

}

class GabineteMagico inherits Mueble {
	
	override method puedeGuardar(cosa){
		return super(cosa) && cosa.esMagico()
	}
}

class Baul inherits Mueble {

	var property volumenMaximo
	
	override method puedeGuardar(cosa){
		return super(cosa) && (cosa.volumen() + self.pesoTotalDeCosasGuardadas() <= volumenMaximo)
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
}

class Cosa {

	var property marca
	var property volumen
	var property esMagico
	var property esReliquia

}

