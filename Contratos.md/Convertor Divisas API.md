### Convertidor de Divisas API

#### Descripción

Este documento especifica el contrato API para el servicio de conversión de moneda. El servicio permite convertir una cantidad específica de una moneda a otra, proporcionando detalles completos sobre la conversión incluyendo tasas de cambio, comisiones y resultados netos.

#### Endpoint

- **URL**: `/api/conversion`
- **Método HTTP**: `GET`

#### Parámetros de la Solicitud

Los siguientes parámetros deben ser proporcionados en la URL de la solicitud:

- `amount`: La cantidad que se desea convertir (número).
- `fromCurrency`: El código de la moneda de origen (ej. `USD`, `BTC`, `ETH`).
- `toCurrency`: El código de la moneda de destino (ej. `USD`, `BTC`, `ETH`).

#### Respuesta Exitosa (200 OK)

En caso de éxito, el servidor responderá con los siguientes datos en formato JSON:

```json
{
  "exchangeRate": 0.012345,        // Tasa de cambio desde fromCurrency a toCurrency
  "fromCurrency": "USD",           // Moneda de origen
  "toCurrency": "BTC",             // Moneda de destino
  "originalAmount": 100.00,        // Monto original en fromCurrency
  "convertedAmount": 1.23,         // Monto convertido a toCurrency
  "commissionFrom": 1.00,          // Comisión en moneda de origen
  "commissionTo": 0.02,            // Comisión en moneda de destino
  "totalReceived": 1.21            // Total recibido después de descontar comisión en toCurrency
}
```

#### Respuestas de Error

El servicio puede responder con los siguientes códigos de estado y mensajes de error:

- **400 Bad Request**: Cuando los parámetros `amount`, `fromCurrency` o `toCurrency` no son válidos o están ausentes.
- **500 Internal Server Error**: Para cualquier error interno en el servidor.

#### Requerimientos Funcionales

1. **Conversión de Moneda**
   - El servicio debe permitir la conversión de una cantidad específica de una moneda a otra utilizando tasas de cambio actualizadas.
   - Debe calcular y proporcionar la cantidad convertida, considerando las tasas de cambio y las comisiones aplicables.

2. **Parámetros de la Solicitud**
   - Los parámetros `amount`, `fromCurrency` y `toCurrency` deben ser obligatorios en la URL de la solicitud para realizar la conversión.
   - `amount`: Debe ser un número válido que represente la cantidad a convertir.
   - `fromCurrency`: Debe ser el código válido de la moneda de origen.
   - `toCurrency`: Debe ser el código válido de la moneda de destino.

#### Requerimientos No Funcionales

1. **Precisión Numérica**
   - El servicio debe manejar los cálculos numéricos con alta precisión para evitar errores de redondeo en las conversiones monetarias.

2. **Disponibilidad y Fiabilidad**
   - El endpoint `/api/conversion` debe estar disponible y responder rápidamente bajo cargas normales y picos de tráfico moderados.
   - El servicio debe manejar adecuadamente los errores y excepciones para garantizar su fiabilidad y disponibilidad continua.

#### Notas Adicionales

- Asegúrese de documentar claramente el uso del endpoint `/api/conversion` para facilitar la integración del frontend y el entendimiento por parte de los desarrolladores.
- Se recomienda utilizar un mecanismo de caché para las tasas de cambio si la frecuencia de actualización es baja, para mejorar el rendimiento y reducir la carga en el sistema externo que proporciona las tasas de cambio.