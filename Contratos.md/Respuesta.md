# Contrato de Drops

Se requerirá la siguiente estructura de respuesta para el contrato de los drops que se mostrarán:

```javascript
const response = [
  {...},
  {...},
  {...},
  //...
];

const objDrops = {
  "icono": "string", 	// icono de la moneda 
  "nombreUsuario": "string",	// nombre del usuario
  "nombreMoneda": "string",	// nombre de la moneda ganada
  "ganancia": "float", 		// Ganancia de la moneda 
  "gananciaCLP": "float", 		// ganancia de la moneda en CLP
  "probabilidad": "float" //  probabilidad de la moneda ganada 
};
