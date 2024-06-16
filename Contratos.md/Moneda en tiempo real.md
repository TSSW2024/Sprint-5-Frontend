# Monedas en tiempo real

Necesito obtener los datos de las monedas en tiempo real owo, para realizar los gráficos del precio histórico de cada moneda.

```javascript
const response = [
  {...},
  {...},
  {...},
  //...
];

const obj = {
  "icono": "string",
  "nombre": "string",
  "siglas": "string",
  "precios": float, // tienen que ser los precios históricos para realizar el gráfico
  "límites": float, // precios históricos, específicamente en un rango de 4 meses, el mas alto y el más bajo
};
