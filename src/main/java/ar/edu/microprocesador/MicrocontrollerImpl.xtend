package ar.edu.microprocesador

import ar.edu.microprocesador.instrucciones.Instruccion
import java.util.ArrayList
import java.util.List

class MicrocontrollerImpl implements Microcontroller {
	
	byte acumuladorA
	byte acumuladorB
	int programCounter
	List<Byte> datos

	new() {
		this.reset
	}
	
	override run(List<Instruccion> program) {
		program.forEach [ instruccion | instruccion.execute(this) ]
	}
	
	/** Manejo del estado del microcontroller */
	override getAAcumulator() {
		acumuladorA
	}
	
	override setAAcumulator(byte value) {
		acumuladorA = value
	}
	
	override getBAcumulator() {
		acumuladorB
	}
	
	override setBAcumulator(byte value) {
		acumuladorB = value
	}
	
	override getPC() {
		programCounter as byte
	}
	
	override advancePC() {
		programCounter = programCounter + 1
	}
	
	override reset() {
		programCounter = 0 as byte
		acumuladorA = 0 as byte
		acumuladorB = 0 as byte
		datos = new ArrayList<Byte>(1024) 
		for (int i : 0..1023) {
			datos.add(0 as byte)
		}
	}
	
	override getData(int addr) {
		datos.get(addr) as byte
	}
	
	override setData(int addr, byte value) {
		datos.set(addr, value)
	}
	
	override copyFrom(Microcontroller micro) {
		acumuladorA = micro.getAAcumulator
		acumuladorB = micro.getBAcumulator
		programCounter = micro.getPC
		programCounter = programCounter - 1
		for (i : 0..1023) {
			val data = micro.getData(i)
			this.setData(i, data)
		}
	}
	
	override copy() {
		return this.clone
	}

	override toString() {
		val result = new StringBuffer() => [
			append("****************************************\n")
			append("*     ESTADO DEL MICROCONTROLADOR      *\n")
			append("* acumA : " + this.AAcumulator + "\n")
			append("* acumB : " + this.BAcumulator  + "\n")
			append("* PC : " + this.PC + "\n")
			append("* datos[0] : " + this.getData(0) + "\n")
			append("* datos[1] : " + this.getData(1) + "\n")
			append("* datos[2] : " + this.getData(2) + "\n")
			append("****************************************\n")
		]
		result.toString
	}
		
}