### API de Gráfico Histórico de Precios de Monedas

#### Descripción

Este documento especifica el contrato API para el servicio de obtención de datos históricos de precios de monedas desde Binance. El servicio permite obtener datos históricos de precios para diferentes monedas, proporcionando detalles completos sobre los precios en distintos intervalos de tiempo.

#### Endpoint

- **URL**: `/api/historical-price`
- **Método HTTP**: `GET`

#### Parámetros de la Solicitud

Los siguientes parámetros deben ser proporcionados en la URL de la solicitud:

- `symbol`: El símbolo del par de criptomonedas (ej. `BTCUSDT`, `ETHUSDT`).
- `interval`: El intervalo de tiempo para los datos de precios (ej. `1m`, `5m`, `15m`, `1h`, `1d`).
- `startTime` (opcional): El tiempo de inicio de los datos en milisegundos (timestamp).
- `endTime` (opcional): El tiempo de finalización de los datos en milisegundos (timestamp).
- `limit` (opcional): El número de registros a obtener (por defecto 500; máximo 1000).

#### Respuesta Exitosa (200 OK)

En caso de éxito, el servidor responderá con los siguientes datos en formato JSON:

```json
[
  {
    "timestamp": 1625097600000,     // Hora del precio en milisegundos
    "price": "34500.00"             // Precio en ese momento
  }
 
]
```

#### Respuestas de Error

El servicio puede responder con los siguientes códigos de estado y mensajes de error:

- **400 Bad Request**: Cuando los parámetros `symbol` o `interval` no son válidos o están ausentes.
- **500 Internal Server Error**: Para cualquier error interno en el servidor.

#### Requerimientos Funcionales

1. **Obtención de Datos Históricos de Precios**
   - El servicio debe permitir la obtención de datos históricos de precios para diferentes pares de criptomonedas utilizando intervalos de tiempo específicos.
   - Debe proporcionar datos detallados incluyendo el precio y la marca de tiempo correspondiente.

2. **Parámetros de la Solicitud**
   - Los parámetros `symbol` y `interval` deben ser obligatorios en la URL de la solicitud para obtener los datos históricos.
   - `symbol`: Debe ser un símbolo válido del par de criptomonedas.
   - `interval`: Debe ser un intervalo de tiempo válido soportado por la API de Binance.

#### Requerimientos No Funcionales

1. **Precisión y Consistencia de Datos**
   - El servicio debe manejar y presentar los datos históricos con alta precisión para asegurar la exactitud de los gráficos.

2. **Disponibilidad y Rendimiento**
   - El endpoint `/api/historical-price` debe estar disponible y responder rápidamente bajo cargas normales y picos de tráfico moderados.
   - El servicio debe manejar adecuadamente los errores y excepciones para garantizar su fiabilidad y disponibilidad continua.

#### Notas Adicionales

- Asegúrese de documentar claramente el uso del endpoint `/api/historical-price` para facilitar la integración del frontend y el entendimiento por parte de los desarrolladores.
- Se recomienda implementar un mecanismo de caché para los datos históricos si la frecuencia de solicitud es alta, para mejorar el rendimiento y reducir la carga en el sistema externo que proporciona los datos.
- Considere la implementación de paginación para manejar grandes volúmenes de datos históricos y mejorar la eficiencia de las solicitudes y respuestas.

Este contrato API detalla cómo obtener datos históricos de precios desde Binance para generar gráficos históricos de diversas monedas, asegurando una integración clara y efectiva entre el frontend y el backend.
