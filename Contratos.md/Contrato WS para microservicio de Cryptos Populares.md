### Contrato WebSocket para Servicio de Criptomonedas Populares

#### Descripción

Este documento especifica el contrato WebSocket para obtener datos en tiempo real de las 5 criptomonedas más populares. El servicio enviará actualizaciones de precios y cambios porcentuales de estas criptomonedas a los clientes conectados.

#### Endpoint WebSocket

- **URL**: `wss://tu-servidor-ws.com/populares`

#### Mensaje de Respuesta Exitoso (Servidor -> Cliente)

El servidor enviará actualizaciones de datos en el siguiente formato JSON:

```json
{
  "cryptos": [
    {
      "name": "BNB",
      "symbol": "BNBUSDT",
      "price": "607.70",
      "change": 0.21,
      "image": "https://bin.bnbstatic.com/image/admin_mgs_image_upload/20220218/94863af2-c980-42cf-a139-7b9f462a36c2.png"
    },
    {
      "name": "BTC",
      "symbol": "BTCUSDT",
      "price": "67006.38",
      "change": -0.77,
      "image": "https://bin.bnbstatic.com/image/admin_mgs_image_upload/20201110/87496d50-2408-43e1-ad4c-78b47b448a6a.png"
    },
    {
      "name": "ETH",
      "symbol": "ETHUSDT",
      "price": "3497.19",
      "change": -0.02,
      "image": "https://bin.bnbstatic.com/image/admin_mgs_image_upload/20201110/3a8c9fe6-2a76-4ace-aa07-415d994de6f0.png"
    },
    {
      "name": "NOT",
      "symbol": "NOTUSDT",
      "price": "0.020623",
      "change": 19.47,
      "image": "https://bin.bnbstatic.com/image/admin_mgs_image_upload/20240511/7e7d2a4f-18fe-4f43-bbff-ec0a4ddfb739.png"
    },
    {
      "name": "PEPE",
      "symbol": "PEPEUSDT",
      "price": "0.00001177",
      "change": -4.46,
      "image": "https://bin.bnbstatic.com/image/admin_mgs_image_upload/20230505/298aecf1-31ac-4439-81d1-21d89d746e9a.png"
    }
  ]
}
```

#### Mensaje de Error (Servidor -> Cliente)

Si ocurre algún error durante la conexión WebSocket, el servidor puede enviar mensajes de error en un formato adecuado para que el cliente lo maneje de manera apropiada.

#### Requerimientos No Funcionales

1. **Latencia Baja**: El servicio debe proporcionar actualizaciones en tiempo real con una latencia mínima para mantener los datos de precios lo más actuales posible.
   
2. **Escalabilidad**: El servidor debe ser capaz de manejar múltiples conexiones simultáneas de clientes y mantener un rendimiento estable bajo cargas variables.

#### Notas Adicionales

- Asegúrate de implementar correctamente la lógica para manejar la conexión WebSocket, incluyendo la apertura, cierre, y manejo de errores.
- Proporciona documentación detallada sobre el manejo de errores específicos que puedan surgir durante la conexión WebSocket para facilitar la depuración por parte del cliente.