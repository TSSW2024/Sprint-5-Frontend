# Contrato de Monedas para el Loot

Se requiere la siguiente estructura de respuesta para el contrato de las monedas que se usarán para el loot:

```javascript
const response = [
  {...},
  {...},
  {...},
  //...
];

const objMonedas = {
  "icono": "string",
  "nombre": "string",
  "siglas": "string",
  "ratio": "float", 
  "ganancia": "float", // porcentaje de la moneda ganada
  "probabilidad": "float", // las probabilidades de todas las monedas que estarán en el loot deben sumar 1
};
