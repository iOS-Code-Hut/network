# network
Simple networking client example

# Protocols
```swift
protocol Endpoint
```
This protocol is the base for your requests, conforming your request struct (preferably) to it allows you to customize headers, httpbody in any way you want.

---

Esse protocolo é a base pros seus requests, implementando-o às suas structs (preferencialmente) permite que você customize headers, corpo da mensagem de qualquer forma que você queira.

```swift
protocol URLSessionProtocol
```
This protocol exists to make testing easier, allowing you to create mockups based on it passing exactly what data you expect it to return

---

Esse protocolo existe para facilitar a implementação de testes, possibilitando que você crie mockups baseados nele, informando qual dado você espera que ele retorne

# Tests
There's a simple test example on how to mock this layer.

This is just an example, you can implement in any way you want!