# Integração com Stripe - Fase 4

Este documento descreve a implementação da Fase 4 do plano de integração com o Stripe, que envolve a exposição das APIs de pagamento.

## Rotas Implementadas

As seguintes rotas foram implementadas no módulo `config-manager` para suportar a integração com o Stripe:

1. **Criar Sessão de Checkout**
   - Rota: `/api/v1/payments/checkout`
   - Método: POST
   - Descrição: Cria uma sessão de checkout do Stripe para um plano específico
   - Autenticação: Usa a sessão do Firebase existente
   - Payload:
     ```json
     {
       "plan_id": "uuid-do-plano",
       "period_id": "uuid-do-periodo",  // opcional
       "success_url": "https://exemplo.com/success",
       "cancel_url": "https://exemplo.com/cancel",
       "user_id": "uuid-do-usuario"
     }
     ```
   - Resposta:
     ```json
     {
       "checkout_url": "https://checkout.stripe.com/...",
       "session_id": "cs_test_..."
     }
     ```

2. **Acessar Portal do Cliente**
   - Rota: `/api/v1/payments/portal/{user_id}`
   - Método: GET
   - Descrição: Cria uma sessão do portal do cliente do Stripe para gerenciar assinaturas
   - Autenticação: Usa a sessão do Firebase existente
   - Resposta:
     ```json
     {
       "portal_url": "https://billing.stripe.com/..."
     }
     ```

3. **Webhook do Stripe**
   - Rota: `/api/v1/payments/webhook`
   - Método: POST
   - Descrição: Endpoint para receber eventos do Stripe
   - Autenticação: Não requer autenticação do usuário, usa assinatura do Stripe
   - Headers:
     - `Stripe-Signature`: Assinatura do webhook fornecida pelo Stripe
   - Resposta:
     ```json
     {
       "status": "success",
       "event_type": "checkout.session.completed"
     }
     ```

## Configuração do Stripe

### Configuração no Painel do Stripe

1. **Webhooks**
   - No painel do Stripe, vá para Developers > Webhooks
   - Adicione um endpoint: `https://seu-dominio.com/api/v1/payments/webhook`
   - Eventos a monitorar:
     - `checkout.session.completed`
     - `invoice.payment_succeeded`
     - `invoice.payment_failed`
     - `customer.subscription.updated`
     - `customer.subscription.deleted`

2. **Produtos e Preços**
   - Crie produtos correspondentes aos planos em seu sistema
   - Para cada produto, crie preços (mensal, anual, etc.)
   - Anote os IDs dos produtos e preços

### Configuração no Ambiente

Certifique-se de que as seguintes variáveis de ambiente estão configuradas:

```
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

## Uso no Frontend

### Integração no Frontend

1. **Checkout**
   ```javascript
   // Exemplo de código para redirecionar para o checkout
   const checkoutSession = async (planId, userId) => {
     try {
       // O usuário deve estar autenticado via Firebase antes desta chamada
       const token = await firebase.auth().currentUser.getIdToken();
       
       const response = await fetch('/api/v1/payments/checkout', {
         method: 'POST',
         headers: {
           'Content-Type': 'application/json',
           'Authorization': `Bearer ${token}`
         },
         body: JSON.stringify({
           plan_id: planId,
           user_id: userId,
           success_url: `${window.location.origin}/payment/success`,
           cancel_url: `${window.location.origin}/payment/canceled`
         })
       });
       
       const data = await response.json();
       
       // Redireciona para a URL de checkout do Stripe
       window.location.href = data.checkout_url;
     } catch (error) {
       console.error('Erro ao iniciar checkout:', error);
     }
   };
   ```

2. **Portal do Cliente**
   ```javascript
   // Exemplo de código para redirecionar para o portal do cliente
   const openCustomerPortal = async (userId) => {
     try {
       // O usuário deve estar autenticado via Firebase antes desta chamada
       const token = await firebase.auth().currentUser.getIdToken();
       
       const response = await fetch(`/api/v1/payments/portal/${userId}`, {
         method: 'GET',
         headers: {
           'Authorization': `Bearer ${token}`
         }
       });
       
       const data = await response.json();
       
       // Redireciona para o portal do cliente do Stripe
       window.location.href = data.portal_url;
     } catch (error) {
       console.error('Erro ao abrir portal:', error);
     }
   };
   ```

## Testes

Para testar as APIs, você pode usar o Postman ou curl:

### Criar Sessão de Checkout
```bash
curl -X POST \
  http://localhost:8082/api/v1/payments/checkout \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer <firebase-token>' \
  -d '{
    "plan_id": "550e8400-e29b-41d4-a716-446655440000",
    "user_id": "a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o5p6",
    "success_url": "http://localhost:3000/payment/success",
    "cancel_url": "http://localhost:3000/payment/canceled"
  }'
```

### Abrir Portal do Cliente
```bash
curl -X GET \
  http://localhost:8082/api/v1/payments/portal/a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o5p6 \
  -H 'Authorization: Bearer <firebase-token>'
```

## Próximos Passos

1. Teste as APIs implementadas.
2. Integre com o Frontend (Fase 5).
3. Implante as mudanças em ambiente de teste.
