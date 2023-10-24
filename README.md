# test_double_v_partners

## _Realizada por Carlos Alejandro Vela Muñoz_

Prueba realizada con:

- Patron bloc
- Inyeccion de dependencias 
- Dart define para variables de entorno

## Como compilar 

- En el archivo api-key.json.tpl eliminar .tpl
- Agregar la url base

### Metodo de compilación
- Revisar que en Vscode el archivo *launch.json* este asi:
 ```bash
  {
    "name": "pragma_test",
    "request": "launch",
    "type": "dart",
    "args": ["--dart-define-from-file","api-key.json"] //add this line
  },
```
- Luego podran compilar normalmente con F5

[Video demostrativo](https://youtu.be/J8rZnIcnnow)


![Logo](https://doublevpartners.com/wp-content/uploads/2023/05/DVP-01-Principal-Fondo-Oscuro.png)