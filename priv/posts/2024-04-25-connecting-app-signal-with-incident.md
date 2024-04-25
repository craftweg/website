---
title: "Connecting App Signal with Incident.io using Cloudflare Workers"
description: "In this blog post I share how we used Cloudflare Workers to connect AppSignal with Incident.io."
tags: ["Incident response"]
---

We started using [Incident.io](https://incident.io) on [Tuist](https://tuist.io) for incident management.
The tool is great, but we were missing a way to connect it with our monitoring system, [AppSignal](https://appsignal.com).
When you look at the integrations available, App Signal isn't there.

Luckily AppSignal supports sending [webhooks when anomalies are detected](https://docs.appsignal.com/application/integrations/webhooks.html#anomaly-detection),
but the schema of the payload and the headers didn't match what Incident.io expected.
For example, Incident.io expects the requests to come with an `Authorization: Bearer xxx` header.

To make the integration work, we decided to use [Cloudflare Workers](https://workers.cloudflare.com/).
We created a worker that transforms the payload sent by AppSignal into the one that Incident.io expects,
and adds the `Authorization` header. The worker is deployed to Cloudflare, and we configured AppSignal to send the webhooks to the worker's URL.
Below is the code of the worker:

```language-js
const token = "...."
export default {
  async fetch(request, env, ctx) {
    const alert = await request.json()
    const { alert_id, metric_name, human_comparison_value, trigger_description } = alert;
    // https://docs.appsignal.com/application/integrations/webhooks.html#exception-incidents

    await fetch("https://api.incident.io/v2/alert_events/http/01HW8CC9EFVC94HW4QDY0FEKSC", { headers: {
      "Authorization": `Bearer ${token}`,
      "Content-Type": "application/json"
    }, method: "POST", body: JSON.stringify({
      "title": `${metric_name} peaked above ${human_comparison_value}`,
      "description": trigger_description,
      "deduplication_key": `${alert_id}`,
      "status": "firing",
      "metadata": {
        ...alert
      }
    })})
    return new Response(JSON.stringify({status: "success"}), {status: 200, headers: {"Content-Type": "application/json"}});
  },
};
```

Hopefully, Incident.io will provide an integration with AppSignal in the future, but until then, this solution works well for us.
